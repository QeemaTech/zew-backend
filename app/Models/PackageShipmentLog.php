<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PackageShipmentLog extends Model
{
    use HasFactory;

    protected $fillable = [
        'package_shipment_id',
        'user_id',
        'type',
        'from_status',
        'to_status',
        'payload',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'payload' => 'array',
        ];
    }

    public function packageShipment(): BelongsTo
    {
        return $this->belongsTo(PackageShipment::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}

