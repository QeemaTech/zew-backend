<?php

namespace Tests\Feature;

use App\Models\Delivery;
use App\Models\DeliveryRequest;
use App\Models\User;
use App\Notifications\DeliveryRequestReviewedNotification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class DeliveryRequestFlowTest extends TestCase
{
    use RefreshDatabase;

    protected User $admin;

    protected User $customer;

    protected function setUp(): void
    {
        parent::setUp();

        Role::firstOrCreate(['name' => 'admin', 'guard_name' => 'web']);
        $this->admin = User::factory()->create();
        $this->admin->assignRole('admin');
        $this->customer = User::factory()->create();
    }

    public function test_authenticated_user_can_view_become_delivery_form(): void
    {
        $this->actingAs($this->customer)
            ->get(route('become-delivery.create'))
            ->assertOk()
            ->assertSee(__('Become a Delivery Person'));
    }

    public function test_authenticated_user_can_submit_delivery_request(): void
    {
        $this->actingAs($this->customer)
            ->post(route('become-delivery.store'), [
                'name' => $this->customer->name,
                'phone' => $this->customer->phone,
                'vehicle_type' => 'motorcycle',
                'vehicle_number' => 'ABC-1234',
                'vehicle_color' => 'Red',
                'message' => 'I want to join.',
            ])
            ->assertRedirect(route('become-delivery.create'))
            ->assertSessionHas('success');

        $this->assertDatabaseHas('delivery_requests', [
            'user_id' => $this->customer->id,
            'vehicle_type' => 'motorcycle',
            'vehicle_number' => 'ABC-1234',
            'vehicle_color' => 'Red',
            'status' => 'pending',
        ]);
    }

    public function test_authenticated_api_user_can_submit_delivery_request(): void
    {
        $token = $this->customer->createToken('test-token')->plainTextToken;

        $this->withToken($token)
            ->postJson('/api/become-delivery', [
                'name' => $this->customer->name,
                'phone' => '201234567890',
                'vehicle_type' => 'motorcycle',
                'vehicle_number' => 'API-1234',
                'vehicle_color' => 'Black',
                'message' => 'Mobile request',
            ])
            ->assertCreated()
            ->assertJson([
                'success' => true,
            ]);

        $this->assertDatabaseHas('delivery_requests', [
            'user_id' => $this->customer->id,
            'phone' => '201234567890',
            'vehicle_number' => 'API-1234',
            'status' => 'pending',
        ]);
    }

    public function test_authenticated_api_user_with_pending_request_gets_conflict(): void
    {
        DeliveryRequest::factory()->forUser($this->customer)->pending()->create([
            'phone' => '201234567890',
        ]);
        $token = $this->customer->createToken('test-token')->plainTextToken;

        $this->withToken($token)
            ->postJson('/api/become-delivery', [
                'name' => $this->customer->name,
                'phone' => '201111111111',
                'vehicle_type' => 'motorcycle',
                'vehicle_number' => 'API-9999',
                'vehicle_color' => 'Black',
            ])
            ->assertStatus(409)
            ->assertJson([
                'success' => false,
            ]);
    }

    public function test_unauthenticated_api_user_can_submit_delivery_request_with_null_user_id(): void
    {
        $this->postJson('/api/become-delivery', [
            'name' => 'Guest User',
            'phone' => '201000000000',
            'vehicle_type' => 'car',
            'vehicle_number' => 'GUEST-123',
            'vehicle_color' => 'White',
        ])
            ->assertCreated()
            ->assertJson([
                'success' => true,
            ]);

        $this->assertDatabaseHas('delivery_requests', [
            'user_id' => null,
            'phone' => '201000000000',
            'vehicle_number' => 'GUEST-123',
            'status' => 'pending',
        ]);
    }

    public function test_user_with_pending_request_is_redirected_from_form(): void
    {
        DeliveryRequest::factory()->forUser($this->customer)->pending()->create();

        $this->actingAs($this->customer)
            ->get(route('become-delivery.create'))
            ->assertRedirect(route('dashboard'))
            ->assertSessionHas('info');
    }

    public function test_user_already_delivery_is_redirected_from_form(): void
    {
        Delivery::factory()->forUser($this->customer)->create();

        $this->actingAs($this->customer)
            ->get(route('become-delivery.create'))
            ->assertRedirect(route('dashboard'))
            ->assertSessionHas('info');
    }

    public function test_admin_can_view_delivery_requests_index(): void
    {
        $this->actingAs($this->admin)
            ->get(route('admin.delivery-requests.index'))
            ->assertOk()
            ->assertSee(__('Delivery Requests'));
    }

    public function test_admin_can_approve_delivery_request(): void
    {
        Notification::fake();

        $request = DeliveryRequest::factory()->forUser($this->customer)->pending()->create([
            'vehicle_type' => 'car',
            'vehicle_number' => 'XYZ-999',
            'vehicle_color' => 'Blue',
        ]);

        $this->actingAs($this->admin)
            ->post(route('admin.delivery-requests.approve', $request))
            ->assertRedirect()
            ->assertSessionHas('success');

        $request->refresh();
        $this->assertSame('accepted', $request->status);
        $this->assertDatabaseHas('deliveries', [
            'user_id' => $this->customer->id,
            'vehicle_type' => 'car',
            'vehicle_number' => 'XYZ-999',
            'vehicle_color' => 'Blue',
        ]);

        Notification::assertSentTo(
            $this->customer,
            DeliveryRequestReviewedNotification::class,
            function (DeliveryRequestReviewedNotification $notification): bool {
                return $notification->deliveryRequest->status === 'accepted';
            }
        );
    }

    public function test_admin_can_reject_delivery_request(): void
    {
        Notification::fake();

        $request = DeliveryRequest::factory()->forUser($this->customer)->pending()->create();

        $this->actingAs($this->admin)
            ->post(route('admin.delivery-requests.reject', $request), [
                'rejection_reason' => 'Not enough capacity.',
            ])
            ->assertRedirect()
            ->assertSessionHas('success');

        $request->refresh();
        $this->assertSame('rejected', $request->status);
        $this->assertSame('Not enough capacity.', $request->rejection_reason);
        $this->assertDatabaseMissing('deliveries', ['user_id' => $this->customer->id]);

        Notification::assertSentTo(
            $this->customer,
            DeliveryRequestReviewedNotification::class,
            function (DeliveryRequestReviewedNotification $notification): bool {
                return $notification->deliveryRequest->status === 'rejected';
            }
        );
    }
}
