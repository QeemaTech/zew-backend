<?php

namespace Tests\Feature;

use App\Models\Vendor;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class VendorCoverImageTest extends TestCase
{
    use RefreshDatabase;

    public function test_vendor_register_stores_image_and_cover_image(): void
    {
        Storage::fake('public');
        Role::firstOrCreate(['name' => 'vendor', 'guard_name' => 'web']);

        $response = $this->postJson('/api/auth/vendor/register', [
            'owner_name' => 'Vendor Owner',
            'owner_email' => 'vendor-owner@example.com',
            'owner_password' => 'Password123!',
            'owner_password_confirmation' => 'Password123!',
            'owner_phone' => '+201001112223',
            'name' => [
                'en' => 'Vendor One',
                'ar' => 'متجر واحد',
            ],
            'phone' => '+201009998887',
            'address' => 'Nasr City, Cairo',
            'image' => UploadedFile::fake()->image('logo.jpg'),
            'cover_image' => UploadedFile::fake()->image('cover.jpg'),
        ]);

        $response->assertStatus(201);

        $vendor = Vendor::query()->first();
        $this->assertNotNull($vendor);
        $this->assertNotNull($vendor->getRawOriginal('image'));
        $this->assertNotNull($vendor->getRawOriginal('cover_image'));

        Storage::disk('public')->assertExists($vendor->getRawOriginal('image'));
        Storage::disk('public')->assertExists($vendor->getRawOriginal('cover_image'));
    }

    public function test_vendor_resource_returns_cover_image(): void
    {
        $vendor = Vendor::factory()->create([
            'slug' => 'vendor-cover-resource',
            'name' => ['en' => 'Vendor', 'ar' => 'متجر'],
            'image' => 'vendors/logo-resource.jpg',
            'cover_image' => 'vendors/cover-resource.jpg',
            'is_active' => true,
        ]);

        $response = $this->getJson("/api/vendors/{$vendor->id}");

        $response->assertStatus(200);
        $response->assertJsonPath('data.cover_image', asset('storage/vendors/cover-resource.jpg'));
    }
}

