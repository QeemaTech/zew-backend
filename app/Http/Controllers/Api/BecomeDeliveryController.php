<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\BecomeDeliveryRequest;
use App\Models\Delivery;
use App\Models\DeliveryRequest;
use Illuminate\Http\JsonResponse;

class BecomeDeliveryController extends Controller
{
    public function store(BecomeDeliveryRequest $request): JsonResponse
    {
        $userId = auth()->id();
        $phone = $request->validated('phone');

        if ($userId && Delivery::where('user_id', $userId)->exists()) {
            return response()->json([
                'success' => false,
                'message' => __('You are already registered as a delivery person.'),
            ], 409);
        }

        if ($userId && DeliveryRequest::where('user_id', $userId)->pending()->exists()) {
            return response()->json([
                'success' => false,
                'message' => __('You already have a pending request.'),
            ], 409);
        }

        if (DeliveryRequest::where('phone', $phone)->pending()->exists()) {
            return response()->json([
                'success' => false,
                'message' => __('A pending request with this phone number already exists.'),
            ], 409);
        }

        $deliveryRequest = DeliveryRequest::create([
            'user_id' => $userId,
            'name' => $request->validated('name'),
            'phone' => $phone,
            'email' => $request->validated('email'),
            'vehicle_type' => $request->validated('vehicle_type'),
            'vehicle_number' => $request->validated('vehicle_number'),
            'vehicle_color' => $request->validated('vehicle_color'),
            'message' => $request->validated('message'),
            'status' => 'pending',
        ]);

        return response()->json([
            'success' => true,
            'message' => __('Your request to become a delivery person has been submitted. We will review it and notify you.'),
            'data' => [
                'status' => $deliveryRequest->status,
            ],
        ], 201);
    }
}
