<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\DeliveryAssignmentResource;
use App\Http\Resources\DeliveryWalletTransactionResource;
use App\Http\Resources\OrderResource;
use App\Models\DeliveryAssignment;
use App\Models\Order;
use App\Services\DeliveryAssignmentService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DeliveryController extends Controller
{
    public function __construct(
        protected DeliveryAssignmentService $assignmentService
    ) {}

    /**
     * Get the authenticated user's delivery profile (must pass delivery.user middleware).
     */
    protected function delivery()
    {
        $delivery = Auth::user()?->delivery;
        if (! $delivery) {
            abort(403, __('You do not have access to the delivery area.'));
        }

        return $delivery;
    }

    /**
     * List wallet transaction history for the current delivery driver.
     */
    public function walletHistory(Request $request): JsonResponse
    {
        $delivery = $this->delivery();
        $perPage = min((int) $request->get('per_page', 15), 50);
        $transactions = $delivery->walletTransactions()->latest()->paginate($perPage);

        return response()->json([
            'success' => true,
            'data' => DeliveryWalletTransactionResource::collection($transactions),
            'meta' => [
                'current_page' => $transactions->currentPage(),
                'last_page' => $transactions->lastPage(),
                'per_page' => $transactions->perPage(),
                'total' => $transactions->total(),
            ],
        ]);
    }

    /**
     * List orders ready for delivery (filtered by driver's zones when assigned).
     */
    public function orders(Request $request): JsonResponse
    {
        $delivery = $this->delivery();



        $activeStatuses = ['assigned', 'picking_up', 'in_transit'];
        $zones = $delivery->zones;
        $perPage = min((int) $request->get('per_page', 15), 50);

        // 1) Unassigned: ready_for_delivery + no active assignment for any delivery driver
        $unassignedQuery = Order::query()
            ->where('status', 'ready_for_delivery')
            ->whereDoesntHave('deliveryAssignments', fn ($q) => $q->whereIn('status', $activeStatuses))
            ->with(['user', 'address', 'vendorOrders.branch', 'vendorOrders.vendor', 'vendorOrders.items']);

        // 2) Assigned to current driver: ready_for_delivery + active assignment for this delivery_id
        $assignedQuery = Order::query()
            ->where('status', 'ready_for_delivery')
            ->whereHas('deliveryAssignments', fn ($q) => $q
                ->where('delivery_id', $delivery->id)
                ->whereIn('status', $activeStatuses)
            )
            ->with(['user', 'address', 'vendorOrders.branch', 'vendorOrders.vendor', 'vendorOrders.items']);

        // Apply zone filtering in PHP because zone polygon evaluation happens there.
        if ($zones->isEmpty()) {
            $unassignedQuery->whereIn('id', []);
            $assignedQuery->whereIn('id', []);
        } else {
            $unassignedIds = (clone $unassignedQuery)
                ->with('address')
                ->get()
                ->filter(function (Order $order) use ($zones) {
                    if (! $order->address || $order->address->latitude === null || $order->address->longitude === null) {
                        return false;
                    }
                    $point = ['lat' => (float) $order->address->latitude, 'lng' => (float) $order->address->longitude];
                    foreach ($zones as $zone) {
                        if ($zone->containsPoint($point)) {
                            return true;
                        }
                    }
                    return false;
                })
                ->pluck('id');

            $assignedIds = (clone $assignedQuery)
                ->with('address')
                ->get()
                ->filter(function (Order $order) use ($zones) {
                    if (! $order->address || $order->address->latitude === null || $order->address->longitude === null) {
                        return false;
                    }
                    $point = ['lat' => (float) $order->address->latitude, 'lng' => (float) $order->address->longitude];
                    foreach ($zones as $zone) {
                        if ($zone->containsPoint($point)) {
                            return true;
                        }
                    }
                    return false;
                })
                ->pluck('id');

            $unassignedQuery->whereIn('id', $unassignedIds);
            $assignedQuery->whereIn('id', $assignedIds);
        }

        $unassignedOrders = $unassignedQuery->latest()->paginate($perPage);
        $assignedOrders = $assignedQuery->latest()->paginate($perPage);

        return response()->json([
            'success' => true,
            'unassigned' => [
                'data' => OrderResource::collection($unassignedOrders),
                'meta' => [
                    'current_page' => $unassignedOrders->currentPage(),
                    'last_page' => $unassignedOrders->lastPage(),
                    'per_page' => $unassignedOrders->perPage(),
                    'total' => $unassignedOrders->total(),
                ],
            ],
            'assigned' => [
                'data' => OrderResource::collection($assignedOrders),
                'meta' => [
                    'current_page' => $assignedOrders->currentPage(),
                    'last_page' => $assignedOrders->lastPage(),
                    'per_page' => $assignedOrders->perPage(),
                    'total' => $assignedOrders->total(),
                ],
            ],
        ]);
    }

    // Keep original route names used in `routes/api.php` (backward compatibility).
    public function ordersReady(Request $request): JsonResponse
    {
        return $this->orders($request);
    }

    /**
     * Show a single order ready for delivery (for assignment).
     */
    public function showOrder(Order $order): JsonResponse
    {
        $delivery = $this->delivery();
        $activeStatuses = ['assigned', 'picking_up', 'in_transit'];

        if ($order->status !== 'ready_for_delivery') {
            return response()->json([
                'success' => false,
                'message' => __('Order not found or not available for assignment.'),
            ], 404);
        }

        $activeAssignmentsQuery = $order->deliveryAssignments()->whereIn('status', $activeStatuses);
        $hasActiveAssignments = $activeAssignmentsQuery->exists();

        // If it's already assigned to another driver, block it.
        if ($hasActiveAssignments && ! $activeAssignmentsQuery->where('delivery_id', $delivery->id)->exists()) {
            return response()->json([
                'success' => false,
                'message' => __('Order not found or not available for assignment.'),
            ], 404);
        }

        $order->load(['user', 'address', 'vendorOrders.branch', 'vendorOrders.vendor', 'vendorOrders.items']);

        // If delivery has zones, require the delivery address to be inside at least one zone.
        // (Matches the filtering logic in orders list.)
        $zones = $delivery->zones;
        if ($zones->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => __('Order not found or not available for assignment.'),
            ], 404);
        }

        if (! $order->address || $order->address->latitude === null || $order->address->longitude === null) {
            return response()->json([
                'success' => false,
                'message' => __('Order not found or not available for assignment.'),
            ], 404);
        }

        $point = ['lat' => (float) $order->address->latitude, 'lng' => (float) $order->address->longitude];
        $inZone = false;
        foreach ($zones as $zone) {
            if ($zone->containsPoint($point)) {
                $inZone = true;
                break;
            }
        }
        if (! $inZone) {
            return response()->json([
                'success' => false,
                'message' => __('Order not found or not available for assignment.'),
            ], 404);
        }

        $estimate = $this->assignmentService->getEstimatedDistanceAndPolyline($order);
        $estimatedKm = $estimate['distance_km'];
        $estimatedCost = $this->assignmentService->calculateShippingCost($estimatedKm);

        $payload = [
            'success' => true,
            'data' => new OrderResource($order),
            'estimated_km' => $estimatedKm,
            'estimated_shipping_cost' => $estimatedCost,
        ];
        if ($estimate['polyline'] !== null) {
            $payload['route_polyline'] = $estimate['polyline'];
        }

        return response()->json($payload);
    }

    // Keep original route names used in `routes/api.php` (backward compatibility).
    public function showOrderReady(Order $order): JsonResponse
    {
        return $this->showOrder($order);
    }

    /**
     * Assign the order to the current delivery driver.
     */
    public function assign(Request $request, Order $order): JsonResponse
    {
        $request->validate([
            'total_km' => ['nullable', 'numeric', 'min:0'],
        ]);

        if ($order->status !== 'ready_for_delivery' || $order->deliveryAssignments()->whereIn('status', ['assigned', 'picking_up', 'in_transit'])->exists()) {
            return response()->json([
                'success' => false,
                'message' => __('Order not found or not available for assignment.'),
            ], 404);
        }

        $delivery = $this->delivery();
        $totalKm = $request->input('total_km');
        if ($totalKm === null || $totalKm === '') {
            $estimate = $this->assignmentService->getEstimatedDistanceAndPolyline($order);
            $totalKm = $estimate['distance_km'];
        } else {
            $totalKm = (float) $totalKm;
        }

        try {
            $assignment = $this->assignmentService->assignOrderToDelivery($order, $delivery, $totalKm);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $assignment->load(['order.user', 'order.address', 'order.vendorOrders.branch', 'order.vendorOrders.vendor', 'order.vendorOrders.items', 'pickups.vendorOrder.branch', 'pickups.vendorOrder.vendor']);

        return response()->json([
            'success' => true,
            'message' => __('Order assigned successfully.'),
            'data' => new DeliveryAssignmentResource($assignment),
        ], 201);
    }

    /**
     * List my delivery assignments (active and optionally delivered).
     */
    public function assignments(Request $request): JsonResponse
    {
        $delivery = $this->delivery();

        $status = $request->get('status', 'active'); // 'active' | 'delivered' | 'all'
        $query = DeliveryAssignment::query()
            ->where('delivery_id', $delivery->id)
            ->with(['order.user', 'order.address', 'order.vendorOrders.branch', 'order.vendorOrders.vendor', 'pickups.vendorOrder.branch', 'pickups.vendorOrder.vendor']);

        if ($status === 'active') {
            $query->whereIn('status', ['assigned', 'picking_up', 'in_transit']);
        } elseif ($status === 'delivered') {
            $query->where('status', 'delivered');
        }

        $perPage = min((int) $request->get('per_page', 15), 50);
        $assignments = $query->latest()->paginate($perPage);

        return response()->json([
            'success' => true,
            'data' => DeliveryAssignmentResource::collection($assignments),
            'meta' => [
                'current_page' => $assignments->currentPage(),
                'last_page' => $assignments->lastPage(),
                'per_page' => $assignments->perPage(),
                'total' => $assignments->total(),
            ],
        ]);
    }

    /**
     * Show a single assignment.
     */
    public function showAssignment(DeliveryAssignment $assignment): JsonResponse
    {
        if ($assignment->delivery_id != $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        $assignment->load(['order.user', 'order.address', 'order.vendorOrders.branch', 'order.vendorOrders.vendor', 'order.vendorOrders.items', 'pickups.vendorOrder.branch', 'pickups.vendorOrder.vendor', 'pickups.vendorOrder.items']);

        return response()->json([
            'success' => true,
            'data' => new DeliveryAssignmentResource($assignment),
        ]);
    }

    /**
     * Start picking up (driver started collecting from vendors).
     */
    public function startPickingUp(DeliveryAssignment $assignment): JsonResponse
    {
        if ($assignment->delivery_id != $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $this->assignmentService->startPickingUp($assignment);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $assignment->load(['order', 'pickups.vendorOrder']);

        return response()->json([
            'success' => true,
            'message' => __('Status updated.'),
            'data' => new DeliveryAssignmentResource($assignment),
        ]);
    }

    /**
     * Mark a pickup as done (driver picked up from this vendor order).
     */
    public function markPickup(Request $request, DeliveryAssignment $assignment): JsonResponse
    {
        $request->validate([
            'vendor_order_id' => ['required', 'integer', 'exists:vendor_orders,id'],
        ]);

        if ($assignment->delivery_id != $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $this->assignmentService->markPickupDone($assignment, (int) $request->vendor_order_id);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $assignment->load(['order', 'pickups.vendorOrder']);

        return response()->json([
            'success' => true,
            'message' => __('Pickup marked done.'),
            'data' => new DeliveryAssignmentResource($assignment),
        ]);
    }

    /**
     * Mark assignment as in transit (heading to customer).
     */
    public function inTransit(DeliveryAssignment $assignment): JsonResponse
    {
        if ($assignment->delivery_id != $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $this->assignmentService->markInTransit($assignment);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $assignment->load(['order', 'pickups.vendorOrder']);

        return response()->json([
            'success' => true,
            'message' => __('Status updated to in transit.'),
            'data' => new DeliveryAssignmentResource($assignment),
        ]);
    }

    /**
     * Mark assignment as delivered.
     */
    public function delivered(DeliveryAssignment $assignment): JsonResponse
    {
        if ($assignment->delivery_id != $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        try {
            $this->assignmentService->markDelivered($assignment);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $assignment->load(['order', 'pickups.vendorOrder']);

        return response()->json([
            'success' => true,
            'message' => __('Order delivered successfully.'),
            'data' => new DeliveryAssignmentResource($assignment),
        ]);
    }

    /**
     * Update assignment distance (e.g. after route calculation from app).
     */
    public function updateDistance(Request $request, DeliveryAssignment $assignment): JsonResponse
    {
        $request->validate([
            'total_km' => ['required', 'numeric', 'min:0'],
        ]);

        if ($assignment->delivery_id != $this->delivery()->id) {
            return response()->json(['success' => false, 'message' => __('Assignment not found.')], 404);
        }

        $this->assignmentService->updateAssignmentDistance($assignment, (float) $request->total_km);
        $assignment->load(['order', 'pickups.vendorOrder']);

        return response()->json([
            'success' => true,
            'message' => __('Distance and shipping cost updated.'),
            'data' => new DeliveryAssignmentResource($assignment),
        ]);
    }
}
