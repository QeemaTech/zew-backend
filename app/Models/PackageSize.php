<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PackageSize extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'height_cm',
        'width_cm',
        'length_cm',
        'size_multiplier',
        'is_active',
        'sort_order',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'height_cm' => 'decimal:2',
            'width_cm' => 'decimal:2',
            'length_cm' => 'decimal:2',
            'size_multiplier' => 'decimal:2',
            'is_active' => 'boolean',
            'sort_order' => 'integer',
        ];
    }

    public function packageShipments(): HasMany
    {
        return $this->hasMany(PackageShipment::class);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }
}

