<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PackageShipmentAssignmentResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'package_shipment_id' => $this->package_shipment_id,
            'delivery_id' => $this->delivery_id,
            'shipment_assignment_status' => $this->status,
            'assigned_at' => $this->assigned_at?->toIso8601String(),
            'picked_up_at' => $this->picked_up_at?->toIso8601String(),
            'delivered_at' => $this->delivered_at?->toIso8601String(),
            'package_shipment' => $this->whenLoaded('packageShipment', function () {
                return [
                    'id' => $this->packageShipment->id,
                    'sender_id' => $this->packageShipment->sender_id,
                    'receiver_name' => $this->packageShipment->receiver_name,
                    'receiver_phone' => $this->packageShipment->receiver_phone,
                    'pickup_address' => $this->packageShipment->pickup_address,
                    'dropoff_address' => $this->packageShipment->dropoff_address,
                    'distance_km' => (float) $this->packageShipment->distance_km,
                    'total_price' => (float) $this->packageShipment->total_price,
                    'shipment_status' => $this->packageShipment->status,
                    'payment_status' => $this->packageShipment->payment_status,
                    'payment_method' => $this->packageShipment->payment_method,
                    'package_image' => $this->packageShipment->package_image ? asset('storage/'.$this->packageShipment->package_image) : null,
                    'sender' => $this->packageShipment->relationLoaded('sender')
                        ? [
                            'id' => $this->packageShipment->sender->id,
                            'name' => $this->packageShipment->sender->name,
                            'phone' => $this->packageShipment->sender->phone,
                            'email' => $this->packageShipment->sender->email,
                        ]
                        : null,
                ];
            }),
            'delivery' => $this->whenLoaded('delivery', function () {
                return [
                    'id' => $this->delivery->id,
                    'vehicle_type' => $this->delivery->vehicle_type,
                    'vehicle_number' => $this->delivery->vehicle_number,
                    'vehicle_color' => $this->delivery->vehicle_color,
                    'user' => new UserResource($this->delivery->user),
                ];
            }),
        ];
    }
}
