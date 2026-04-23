<?php

namespace App\Services;

use App\Models\Delivery;
use App\Models\PackageShipment;
use App\Models\PackageShipmentAssignment;
use App\Repositories\PackageShipmentRepository;
use Illuminate\Support\Facades\DB;

class PackageShipmentAssignmentService
{
    public function __construct(
        protected PackageShipmentRepository $packageShipmentRepository
    ) {}

    public function assignToDelivery(PackageShipment $shipment, Delivery $delivery): PackageShipmentAssignment
    {
        return DB::transaction(function () use ($shipment, $delivery) {
            $shipment = PackageShipment::query()->lockForUpdate()->findOrFail($shipment->id);

            if ($shipment->status === PackageShipment::STATUS_CANCELLED || $shipment->status === PackageShipment::STATUS_DELIVERED) {
                throw new \InvalidArgumentException(__('Shipment cannot be assigned.'));
            }

            $activeAssignment = $this->packageShipmentRepository->getActiveAssignment($shipment);
            if ($activeAssignment) {
                throw new \InvalidArgumentException(__('Shipment is already assigned to a delivery.'));
            }

            $assignment = $this->packageShipmentRepository->createAssignment([
                'package_shipment_id' => $shipment->id,
                'delivery_id' => $delivery->id,
                'status' => 'assigned',
                'assigned_at' => now(),
            ]);

            $shipment->update(['status' => PackageShipment::STATUS_ASSIGNED]);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $delivery->user_id,
                'type' => 'assignment_created',
                'from_status' => null,
                'to_status' => PackageShipment::STATUS_ASSIGNED,
                'payload' => ['delivery_id' => $delivery->id],
            ]);

            return $assignment->load(['packageShipment', 'delivery.user']);
        });
    }

    public function startPickingUp(PackageShipmentAssignment $assignment): PackageShipmentAssignment
    {
        return DB::transaction(function () use ($assignment) {
            $assignment = PackageShipmentAssignment::query()->lockForUpdate()->findOrFail($assignment->id);
            if (! in_array($assignment->status, ['assigned'], true)) {
                throw new \InvalidArgumentException(__('Invalid assignment status transition.'));
            }

            $this->packageShipmentRepository->updateAssignment($assignment, [
                'status' => 'picking_up',
                'picked_up_at' => now(),
            ]);

            $shipment = $assignment->packageShipment()->lockForUpdate()->firstOrFail();
            $shipment->update(['status' => PackageShipment::STATUS_PICKED_UP]);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $assignment->delivery?->user_id,
                'type' => 'assignment_status_change',
                'from_status' => 'assigned',
                'to_status' => 'picking_up',
                'payload' => ['assignment_id' => $assignment->id],
            ]);

            return $assignment->refresh();
        });
    }

    public function markInTransit(PackageShipmentAssignment $assignment): PackageShipmentAssignment
    {
        return DB::transaction(function () use ($assignment) {
            $assignment = PackageShipmentAssignment::query()->lockForUpdate()->findOrFail($assignment->id);
            if (! in_array($assignment->status, ['assigned', 'picking_up'], true)) {
                throw new \InvalidArgumentException(__('Invalid assignment status transition.'));
            }

            $fromStatus = $assignment->status;
            $this->packageShipmentRepository->updateAssignment($assignment, [
                'status' => 'in_transit',
            ]);

            $shipment = $assignment->packageShipment()->lockForUpdate()->firstOrFail();
            $shipment->update(['status' => PackageShipment::STATUS_IN_TRANSIT]);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $assignment->delivery?->user_id,
                'type' => 'assignment_status_change',
                'from_status' => $fromStatus,
                'to_status' => 'in_transit',
                'payload' => ['assignment_id' => $assignment->id],
            ]);

            return $assignment->refresh();
        });
    }

    public function markDelivered(PackageShipmentAssignment $assignment): PackageShipmentAssignment
    {
        return DB::transaction(function () use ($assignment) {
            $assignment = PackageShipmentAssignment::query()->lockForUpdate()->findOrFail($assignment->id);
            if ($assignment->status === 'delivered') {
                throw new \InvalidArgumentException(__('Shipment assignment already delivered.'));
            }

            $this->packageShipmentRepository->updateAssignment($assignment, [
                'status' => 'delivered',
                'delivered_at' => now(),
            ]);

            $shipment = $assignment->packageShipment()->lockForUpdate()->firstOrFail();
            $shipmentUpdate = ['status' => PackageShipment::STATUS_DELIVERED];
            if ($shipment->payment_method === 'cash' && $shipment->payment_status !== PackageShipment::PAYMENT_PAID) {
                $shipmentUpdate['payment_status'] = PackageShipment::PAYMENT_PAID;
                $shipmentUpdate['paid_at'] = now();
            }
            $shipment->update($shipmentUpdate);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $assignment->delivery?->user_id,
                'type' => 'shipment_status_change',
                'from_status' => null,
                'to_status' => PackageShipment::STATUS_DELIVERED,
                'payload' => ['assignment_id' => $assignment->id],
            ]);

            if ($shipment->payment_method === 'cash' && $shipment->payment_status === PackageShipment::PAYMENT_PAID) {
                $this->packageShipmentRepository->createLog([
                    'package_shipment_id' => $shipment->id,
                    'user_id' => $assignment->delivery?->user_id,
                    'type' => 'payment_change',
                    'from_status' => PackageShipment::PAYMENT_PENDING,
                    'to_status' => PackageShipment::PAYMENT_PAID,
                    'payload' => [
                        'payment_method' => 'cash',
                        'confirmed_by_delivery_id' => $assignment->delivery_id,
                    ],
                ]);
            }

            return $assignment->refresh();
        });
    }
}
