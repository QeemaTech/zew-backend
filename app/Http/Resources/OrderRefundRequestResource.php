<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderRefundRequestResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'order_id' => $this->order_id,
            'order' => new OrderResource($this->whenLoaded('order')),
            'user_id' => $this->user_id,
            'status' => $this->status,
            'reason' => $this->reason,
            'details' => $this->details,
        ];
    }
}
