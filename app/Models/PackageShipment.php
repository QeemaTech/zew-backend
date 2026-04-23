<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class PackageShipment extends Model
{
    use HasFactory, SoftDeletes;

    public const STATUS_PENDING = 'pending';
    public const STATUS_ACCEPTED = 'accepted';
    public const STATUS_ASSIGNED = 'assigned';
    public const STATUS_PICKED_UP = 'picked_up';
    public const STATUS_IN_TRANSIT = 'in_transit';
    public const STATUS_DELIVERED = 'delivered';
    public const STATUS_CANCELLED = 'cancelled';

    public const PAYMENT_PENDING = 'pending';
    public const PAYMENT_PAID = 'paid';
    public const PAYMENT_FAILED = 'failed';
    public const PAYMENT_REFUNDED = 'refunded';

    protected $fillable = [
        'sender_id',
        'package_size_id',
        'receiver_name',
        'receiver_phone',
        'pickup_address',
        'pickup_lat',
        'pickup_lng',
        'dropoff_address',
        'dropoff_lat',
        'dropoff_lng',
        'package_image',
        'package_size_name_snapshot',
        'package_height_cm',
        'package_width_cm',
        'package_length_cm',
        'size_multiplier_snapshot',
        'distance_km',
        'price_per_km',
        'base_price',
        'total_price',
        'status',
        'payment_status',
        'payment_method',
        'wallet_used',
        'refund_status',
        'refunded_total',
        'paid_at',
        'notes',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'pickup_lat' => 'decimal:7',
            'pickup_lng' => 'decimal:7',
            'dropoff_lat' => 'decimal:7',
            'dropoff_lng' => 'decimal:7',
            'package_height_cm' => 'decimal:2',
            'package_width_cm' => 'decimal:2',
            'package_length_cm' => 'decimal:2',
            'size_multiplier_snapshot' => 'decimal:2',
            'distance_km' => 'decimal:2',
            'price_per_km' => 'decimal:2',
            'base_price' => 'decimal:2',
            'total_price' => 'decimal:2',
            'wallet_used' => 'decimal:2',
            'refunded_total' => 'decimal:2',
            'paid_at' => 'datetime',
        ];
    }

    public function sender(): BelongsTo
    {
        return $this->belongsTo(User::class, 'sender_id');
    }

    public function packageSize(): BelongsTo
    {
        return $this->belongsTo(PackageSize::class, 'package_size_id');
    }

    public function assignments(): HasMany
    {
        return $this->hasMany(PackageShipmentAssignment::class);
    }

    public function logs(): HasMany
    {
        return $this->hasMany(PackageShipmentLog::class)->latest();
    }

    public function currentAssignment(): HasMany
    {
        return $this->assignments()->whereIn('status', ['assigned', 'picking_up', 'in_transit']);
    }

    public function scopePending($query)
    {
        return $query->where('status', self::STATUS_PENDING);
    }

    public function scopeAssigned($query)
    {
        return $query->where('status', self::STATUS_ASSIGNED);
    }

    public function scopeInTransit($query)
    {
        return $query->where('status', self::STATUS_IN_TRANSIT);
    }

    public function scopeDelivered($query)
    {
        return $query->where('status', self::STATUS_DELIVERED);
    }

    public function scopeCancelled($query)
    {
        return $query->where('status', self::STATUS_CANCELLED);
    }
}
