<?php

namespace App\Repositories;

use App\Models\PackageShipment;
use App\Models\PackageShipmentAssignment;
use App\Models\PackageShipmentLog;
use Illuminate\Pagination\LengthAwarePaginator;

class PackageShipmentRepository
{
    /**
     * @param  array{
     *   search?: string,
     *   status?: string,
     *   payment_status?: string,
     *   sender_id?: int|string,
     *   receiver_phone?: string,
     * }  $filters
     */
    public function getPaginatedShipments(int $perPage = 15, array $filters = []): LengthAwarePaginator
    {
        $query = PackageShipment::query()
            ->with(['sender', 'packageSize', 'assignments.delivery.user']);

        if (! empty($filters['search'])) {
            $search = trim((string) $filters['search']);
            $query->where(function ($q) use ($search) {
                $q->where('id', $search)
                    ->orWhere('receiver_name', 'like', "%{$search}%")
                    ->orWhere('receiver_phone', 'like', "%{$search}%")
                    ->orWhere('pickup_address', 'like', "%{$search}%")
                    ->orWhere('dropoff_address', 'like', "%{$search}%");
            });
        }

        if (isset($filters['status']) && $filters['status'] !== '') {
            $query->where('status', $filters['status']);
        }

        if (isset($filters['payment_status']) && $filters['payment_status'] !== '') {
            $query->where('payment_status', $filters['payment_status']);
        }

        if (isset($filters['sender_id']) && $filters['sender_id'] !== '') {
            $query->where('sender_id', $filters['sender_id']);
        }

        if (isset($filters['receiver_phone']) && $filters['receiver_phone'] !== '') {
            $query->where('receiver_phone', $filters['receiver_phone']);
        }

        return $query->latest()->paginate($perPage);
    }

    public function getShipmentById(int $id): ?PackageShipment
    {
        return PackageShipment::query()
            ->with(['sender', 'packageSize', 'assignments.delivery.user', 'logs.user'])
            ->find($id);
    }

    public function getShipmentByIdForSender(int $id, int $senderId): ?PackageShipment
    {
        return PackageShipment::query()
            ->with(['sender', 'packageSize', 'assignments.delivery.user', 'logs.user'])
            ->where('sender_id', $senderId)
            ->find($id);
    }

    /**
     * @param  array{
     *   status?: string,
     *   payment_status?: string,
     * }  $filters
     */
    public function getPaginatedForUser(int $userId, ?string $phone, int $perPage = 15, array $filters = []): LengthAwarePaginator
    {
        $query = PackageShipment::query()
            ->with(['sender', 'packageSize', 'assignments.delivery.user'])
            ->where(function ($q) use ($userId, $phone) {
                $q->where('sender_id', $userId);
                if (! empty($phone)) {
                    $q->orWhere('receiver_phone', $phone);
                }
            });

        if (isset($filters['status']) && $filters['status'] !== '') {
            $query->where('status', $filters['status']);
        }

        if (isset($filters['payment_status']) && $filters['payment_status'] !== '') {
            $query->where('payment_status', $filters['payment_status']);
        }

        return $query->latest()->paginate($perPage);
    }

    public function getShipmentByIdForUser(int $id, int $userId, ?string $phone): ?PackageShipment
    {
        return PackageShipment::query()
            ->with(['sender', 'packageSize', 'assignments.delivery.user', 'logs.user'])
            ->where('id', $id)
            ->where(function ($q) use ($userId, $phone) {
                $q->where('sender_id', $userId);
                if (! empty($phone)) {
                    $q->orWhere('receiver_phone', $phone);
                }
            })
            ->first();
    }

    public function getAvailableForDelivery(int $perPage = 15): LengthAwarePaginator
    {
        return PackageShipment::query()
            ->with(['sender', 'packageSize'])
            ->where('status', PackageShipment::STATUS_ACCEPTED)
            ->orWhere('status', PackageShipment::STATUS_PENDING)
            ->whereDoesntHave('assignments', fn ($q) => $q->whereIn('status', ['assigned', 'picking_up', 'in_transit']))
            ->latest()
            ->paginate($perPage);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function createShipment(array $data): PackageShipment
    {
        return PackageShipment::query()->create($data);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function updateShipment(PackageShipment $shipment, array $data): bool
    {
        return $shipment->update($data);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function createAssignment(array $data): PackageShipmentAssignment
    {
        return PackageShipmentAssignment::query()->create($data);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function updateAssignment(PackageShipmentAssignment $assignment, array $data): bool
    {
        return $assignment->update($data);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function createLog(array $data): PackageShipmentLog
    {
        return PackageShipmentLog::query()->create($data);
    }

    public function getActiveAssignment(PackageShipment $shipment): ?PackageShipmentAssignment
    {
        return $shipment->assignments()
            ->whereIn('status', ['assigned', 'picking_up', 'in_transit'])
            ->latest()
            ->first();
    }
}
