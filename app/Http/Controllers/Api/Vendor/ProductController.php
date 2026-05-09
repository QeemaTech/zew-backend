<?php

namespace App\Http\Controllers\Api\Vendor;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use App\Services\ProductService;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class ProductController extends Controller
{
    public function __construct(protected ProductService $service) {}

    public function show(int $id): JsonResponse
    {
        $vendor = Auth::user()?->vendor();
        if (! $vendor) {
            return response()->json([
                'success' => false,
                'message' => __('Vendor account not found.'),
            ], 404);
        }

        $product = Product::query()
            ->where('vendor_id', $vendor->id)
            ->with([
                'vendor',
                'categories',
                'images',
                'ratings',
                'variants.values.variantOption.variant',
                'variants.branchVariantStocks',
                'branchProductStocks',
            ])
            ->find($id);

        if (! $product) {
            return response()->json([
                'success' => false,
                'message' => __('Product not found.'),
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => new ProductResource($product),
        ]);
    }

    public function toggleActive(int $id): JsonResponse
    {
        $vendor = Auth::user()?->vendor();
        if (! $vendor) {
            return response()->json([
                'success' => false,
                'message' => __('Vendor account not found.'),
            ], 404);
        }

        $product = Product::query()
            ->where('vendor_id', $vendor->id)
            ->find($id);

        if (! $product) {
            return response()->json([
                'success' => false,
                'message' => __('Product not found.'),
            ], 404);
        }

        $product = $this->service->toggleActive($product);

        return response()->json([
            'success' => true,
            'message' => __('Product status updated successfully.'),
            'data' => new ProductResource($product->load(['vendor', 'categories', 'images', 'ratings'])),
        ]);
    }

    public function destroy(int $id): JsonResponse
    {
        if (! canCreateProducts()) {
            return response()->json([
                'success' => false,
                'message' => __('Only vendor owners can delete products. Branch users cannot delete products.'),
            ], 403);
        }

        $vendor = Auth::user()?->vendor();
        if (! $vendor) {
            return response()->json([
                'success' => false,
                'message' => __('Vendor account not found.'),
            ], 404);
        }

        $product = Product::query()
            ->where('vendor_id', $vendor->id)
            ->find($id);

        if (! $product) {
            return response()->json([
                'success' => false,
                'message' => __('Product not found.'),
            ], 404);
        }

        $this->service->deleteProduct($product);

        return response()->json([
            'success' => true,
            'message' => __('Product deleted successfully.'),
        ]);
    }
}

