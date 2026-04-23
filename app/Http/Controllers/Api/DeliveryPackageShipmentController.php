<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\DeliveryPackageShipments\AssignRequest;
use App\Http\Resources\PackageShipmentAssignmentResource;
use App\Http\Resources\PackageShipmentResource;
use App\Models\PackageShipment;
use App\Models\PackageShipmentAssignment;
use App\Services\PackageShipmentAssignmentService;
use App\Services\PackageShipmentService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DeliveryPackageShipmentController extends Controller
{
    public function __construct(
        protected PackageShipmentService $packageShipmentService,
        protected PackageShipmentAssignmentService $assignmentService
    ) {}

    protected function delivery()
    {
        $delivery = Auth::user()?->delivery;
        if (! $delivery) {
            abort(403, __('You do not have access to the delivery area.'));
        }

        return $delivery;
    }

    public function available(Request $request): JsonResponse
    {
        $perPage = min((int) $request->get('per_page', 15), 50);
        $shipments = $this->packageShipmentService->getAvailableForDelivery($perPage);

        return response()->json([
            'success' => true,
            'data' => PackageShipmentResource::collection($shipments),
            'meta' => [
                'current_page' => $shipments->currentPage(),
                'last_page' => $shipments->lastPage(),
                'per_page' => $shipments->perPage(),
                'total' => $shipments->total(),
            ],
        ]);
    }

    public function assignments(Request $request): JsonResponse
    {
        $delivery = $this->delivery();
        $status = (string) $request->get('status', 'active'); // active|delivered|all
        $perPage = min((int) $request->get('per_page', 15), 50);

        $query = PackageShipmentAssignment::query()
            ->where('delivery_id', $delivery->id)
            ->with(['delivery.user', 'packageShipment.sender', 'packageShipment.packageSize']);

        if ($status === 'active') {
            $query->whereIn('status', ['assigned', 'picking_up', 'in_transit']);
        } elseif ($status === 'delivered') {
            $query->where('status', 'delivered');
        }

        $assignments = $query->latest()->paginate($perPage);

        return response()->json([
            'success' => true,
            'data' => PackageShipmentAssignmentResource::collection($assignments),
            'meta' => [
                'current_page' => $assignments->currentPage(),
                'last_page' => $assignments->lastPage(),
                'per_page' => $assignments->perPage(),
                'total' => $assignments->total(),
            ],
        ]);
    }

    public function showAssignment(PackageShipmentAssignment $assignment): JsonResponse
    {
        if ((int) $assignment->delivery_id !== (int) $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        $assignment->load(['delivery.user', 'packageShipment.sender', 'packageShipment.packageSize']);

        return response()->json([
            'success' => true,
            'data' => new PackageShipmentAssignmentResource($assignment),
        ]);
    }

    public function assign(AssignRequest $request, PackageShipment $packageShipment): JsonResponse
    {
        try {
            $assignment = $this->assignmentService->assignToDelivery($packageShipment, $this->delivery());
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $assignment->load(['delivery.user']);

        return response()->json([
            'success' => true,
            'message' => __('Package shipment assigned successfully.'),
            'data' => new PackageShipmentAssignmentResource($assignment),
        ], 201);
    }

    public function startPickingUp(PackageShipmentAssignment $assignment): JsonResponse
    {
        if ((int) $assignment->delivery_id !== (int) $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $assignment = $this->assignmentService->startPickingUp($assignment);
        } catch (\InvalidArgumentException $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 422);
        }

        return response()->json([
            'success' => true,
            'message' => __('Status updated.'),
            'data' => new PackageShipmentAssignmentResource($assignment->load('delivery.user')),
        ]);
    }

    public function inTransit(PackageShipmentAssignment $assignment): JsonResponse
    {
        if ((int) $assignment->delivery_id !== (int) $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $assignment = $this->assignmentService->markInTransit($assignment);
        } catch (\InvalidArgumentException $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 422);
        }

        return response()->json([
            'success' => true,
            'message' => __('Status updated to in transit.'),
            'data' => new PackageShipmentAssignmentResource($assignment->load('delivery.user')),
        ]);
    }

    public function delivered(PackageShipmentAssignment $assignment): JsonResponse
    {
        if ((int) $assignment->delivery_id !== (int) $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $assignment = $this->assignmentService->markDelivered($assignment);
        } catch (\InvalidArgumentException $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 422);
        }

        return response()->json([
            'success' => true,
            'message' => __('Package shipment delivered successfully.'),
            'data' => new PackageShipmentAssignmentResource($assignment->load('delivery.user')),
        ]);
    }
}
