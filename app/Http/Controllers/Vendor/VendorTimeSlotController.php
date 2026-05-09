<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\VendorTimeSlots\StoreRequest;
use App\Http\Requests\Admin\VendorTimeSlots\UpdateRequest;
use App\Models\Vendor;
use App\Models\VendorTimeSlot;
use App\Services\VendorTimeSlotService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class VendorTimeSlotController extends Controller
{
    public function __construct(
        protected VendorTimeSlotService $service
    ) {}

    protected function getVendor(): ?Vendor
    {
        return Auth::user()->vendor();
    }

    public function store(StoreRequest $request): RedirectResponse
    {
        Log::info('Vendor dashboard time-slot store payload', [
            'user_id' => Auth::id(),
            'payload' => $request->only(['day_of_week', 'opens_at', 'closes_at', 'is_active']),
        ]);

        $vendor = $this->getVendor();
        if (! $vendor) {
            abort(404, __('Vendor account not found.'));
        }

        $this->service->createForVendor($vendor, [
            'day_of_week' => $request->integer('day_of_week'),
            'opens_at' => $request->input('opens_at'),
            'closes_at' => $request->input('closes_at'),
            'is_active' => $request->boolean('is_active'),
        ]);

        return redirect()->route('vendor.settings.index')
            ->with('success', __('Time slot added successfully.'));
    }

    public function update(UpdateRequest $request, VendorTimeSlot $timeSlot): RedirectResponse
    {
        Log::info('Vendor dashboard time-slot update payload', [
            'user_id' => Auth::id(),
            'time_slot_id' => $timeSlot->id,
            'payload' => $request->only(['day_of_week', 'opens_at', 'closes_at', 'is_active']),
        ]);

        $vendor = $this->getVendor();
        if (! $vendor) {
            abort(404, __('Vendor account not found.'));
        }

        if ($timeSlot->vendor_id != $vendor->id) {
            abort(404);
        }

        $this->service->update($timeSlot, [
            'day_of_week' => $request->integer('day_of_week'),
            'opens_at' => $request->input('opens_at'),
            'closes_at' => $request->input('closes_at'),
            'is_active' => $request->boolean('is_active'),
        ]);

        Log::info('Vendor dashboard time-slot updated row', [
            'time_slot_id' => $timeSlot->id,
            'fresh' => $timeSlot->fresh()?->only(['id', 'day_of_week', 'opens_at', 'closes_at', 'is_active']),
        ]);

        return redirect()->route('vendor.settings.index')
            ->with('success', __('Time slot updated successfully.'));
    }

    public function destroy(VendorTimeSlot $timeSlot): RedirectResponse
    {
        $vendor = $this->getVendor();
        if (! $vendor) {
            abort(404, __('Vendor account not found.'));
        }

        if ($timeSlot->vendor_id != $vendor->id) {
            abort(404);
        }

        $this->service->delete($timeSlot);

        return redirect()->route('vendor.settings.index')
            ->with('success', __('Time slot deleted successfully.'));
    }
}
