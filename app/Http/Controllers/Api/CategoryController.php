<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\CategoryResource;
use App\Http\Resources\VendorResource;
use App\Models\Category;
use App\Models\Vendor;
use App\Services\CategoryService;

class CategoryController extends Controller
{
    protected CategoryService $service;

    public function __construct(CategoryService $service)
    {
        $this->service = $service;
    }

    public function index()
    {
        $perPage = request()->get('per_page', 15);
        $filters = [
            'search' => request()->get('search', ''),
            'status' => request()->get('status', ''),
            'featured' => request()->get('featured', ''),
            'parent_id' => request()->get('parent_id', ''),
            'sort' => request()->get('sort', ''),
        ];
        $categories = $this->service->getPaginatedCategories($perPage, $filters);

        return CategoryResource::collection($categories);
    }

    public function show(Category $category)
    {
        $category = $this->service->getCategoryById($category->id);

        return new CategoryResource($category);
    }

    public function vendors(Category $category)
    {
        $perPage = (int) request()->get('per_page', 15);

        $vendors = Vendor::query()
            ->active()
            ->whereHas('products.categories', function ($query) use ($category) {
                $query->where('categories.id', $category->id);
            })
            ->withAvg(['ratings as rating_average' => function ($query) {
                $query->where('is_visible', true);
            }], 'rating')
            ->withCount(['ratings as rating_count' => function ($query) {
                $query->where('is_visible', true);
            }])
            ->paginate($perPage);

        return VendorResource::collection($vendors);
    }
}
