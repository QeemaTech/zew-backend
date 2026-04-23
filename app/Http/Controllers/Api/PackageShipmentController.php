<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\PackageShipments\CalculatePriceRequest;
use App\Http\Requests\Api\PackageShipments\PayRequest;
use App\Http\Requests\Api\PackageShipments\StoreRequest;
use App\Http\Resources\PackageShipmentResource;
use App\Http\Resources\PackageSizeResource;
use App\Models\PackageShipment;
use App\Services\PackageShipmentService;
use App\Services\PackageSizeService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PackageShipmentController extends Controller
{
    public function __construct(
        protected PackageShipmentService $packageShipmentService,
        protected PackageSizeService $packageSizeService
    ) {}

    public function packageSizes(): JsonResponse
    {
        $sizes = $this->packageSizeService->getActiveSizes();

        return response()->json([
            'success' => true,
            'data' => PackageSizeResource::collection($sizes),
        ]);
    }

    public function calculatePrice(CalculatePriceRequest $request): JsonResponse
    {
        $pricing = $this->packageShipmentService->calculatePrice($request->validated());

        return response()->json([
            'success' => true,
            'data' => $pricing,
        ]);
    }

    public function store(StoreRequest $request): JsonResponse
    {
        $user = Auth::user();
        $shipment = $this->packageShipmentService->createShipment($user->id, $request->validated());
        $shipment->load(['sender', 'packageSize', 'assignments.delivery.user']);

        return response()->json([
            'success' => true,
            'message' => __('Package shipment created successfully.'),
            'data' => new PackageShipmentResource($shipment),
        ], 201);
    }

    public function index(Request $request): JsonResponse
    {
        $user = Auth::user();
        $perPage = min((int) $request->get('per_page', 15), 50);
        $filters = [
            'status' => (string) $request->get('status', ''),
            'payment_status' => (string) $request->get('payment_status', ''),
        ];

        $shipments = $this->packageShipmentService->getPaginatedForUser($user->id, $user->phone, $perPage, $filters);

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

    public function show(int $id): JsonResponse
    {
        $user = Auth::user();
        $shipment = $this->packageShipmentService->getShipmentByIdForUser($id, $user->id, $user->phone);

        if (! $shipment) {
            return response()->json([
                'success' => false,
                'message' => __('Package shipment not found.'),
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => new PackageShipmentResource($shipment),
        ]);
    }


    public function pay(PayRequest $request, PackageShipment $packageShipment): JsonResponse
    {
        $user = Auth::user();
        if ((int) $packageShipment->sender_id !== (int) $user->id) {
            return response()->json([
                'success' => false,
                'message' => __('You are not allowed to pay this shipment.'),
            ], 403);
        }

        $validated = $request->validated();
        try {
            $shipment = $this->packageShipmentService->payShipment(
                $packageShipment,
                (string) $validated['payment_method'],
                (bool) ($validated['use_wallet'] ?? false)
            );
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }
        $shipment->load(['sender', 'packageSize', 'assignments.delivery.user']);

        return response()->json([
            'success' => true,
            'message' => __('Package shipment paid successfully.'),
            'data' => new PackageShipmentResource($shipment),
        ]);
    }

    public function cancel(PackageShipment $packageShipment): JsonResponse
    {
        $user = Auth::user();

        try {
            $shipment = $this->packageShipmentService->cancelBySender($packageShipment, $user->id);
        } catch (\InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $shipment->load(['sender', 'packageSize', 'assignments.delivery.user']);

        return response()->json([
            'success' => true,
            'message' => __('Package shipment cancelled successfully.'),
            'data' => new PackageShipmentResource($shipment),
        ]);
    }
}
