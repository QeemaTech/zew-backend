<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PackageSizeResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'height_cm' => (float) $this->height_cm,
            'width_cm' => (float) $this->width_cm,
            'length_cm' => (float) $this->length_cm,
            'size_multiplier' => (float) $this->size_multiplier,
            'is_active' => (bool) $this->is_active,
            'sort_order' => (int) $this->sort_order,
        ];
    }
}

