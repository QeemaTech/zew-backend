<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PackageShipmentResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'sender_id' => $this->sender_id,
            'receiver_name' => $this->receiver_name,
            'receiver_phone' => $this->receiver_phone,
            'package_size_id' => $this->package_size_id,
            'pickup_address' => $this->pickup_address,
            'pickup_lat' => (float) $this->pickup_lat,
            'pickup_lng' => (float) $this->pickup_lng,
            'dropoff_address' => $this->dropoff_address,
            'dropoff_lat' => (float) $this->dropoff_lat,
            'dropoff_lng' => (float) $this->dropoff_lng,
            'package_image' => $this->package_image ? asset('storage/'.$this->package_image) : null,
            'package_size_name_snapshot' => $this->package_size_name_snapshot,
            'package_height_cm' => (float) $this->package_height_cm,
            'package_width_cm' => (float) $this->package_width_cm,
            'package_length_cm' => (float) $this->package_length_cm,
            'size_multiplier_snapshot' => (float) $this->size_multiplier_snapshot,
            'distance_km' => (float) $this->distance_km,
            'price_per_km' => (float) $this->price_per_km,
            'base_price' => (float) $this->base_price,
            'total_price' => (float) $this->total_price,
            'shipment_status' => $this->status,
            'payment_status' => $this->payment_status,
            'payment_method' => $this->payment_method,
            'wallet_used' => (float) $this->wallet_used,
            'refund_status' => $this->refund_status,
            'refunded_total' => (float) $this->refunded_total,
            'paid_at' => $this->paid_at?->toIso8601String(),
            'notes' => $this->notes,
            'created_at' => $this->created_at?->toIso8601String(),
            'updated_at' => $this->updated_at?->toIso8601String(),
            'sender' => new UserResource($this->whenLoaded('sender')),
            'package_size' => new PackageSizeResource($this->whenLoaded('packageSize')),
            'assignments' => PackageShipmentAssignmentResource::collection($this->whenLoaded('assignments')),
        ];
    }
}
