<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\PackageSizes\CreateRequest;
use App\Http\Requests\Admin\PackageSizes\UpdateRequest;
use App\Models\PackageSize;
use App\Services\PackageSizeService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class PackageSizeController extends Controller
{
    public function __construct(
        protected PackageSizeService $service
    ) {}

    public function index(Request $request): View
    {
        $perPage = (int) $request->get('per_page', 15);
        $filters = [
            'search' => (string) $request->get('search', ''),
            'is_active' => $request->get('is_active', ''),
        ];

        $packageSizes = $this->service->getPaginatedPackageSizes($perPage, $filters);

        return view('admin.package_sizes.index', compact('packageSizes', 'filters'));
    }

    public function create(): View
    {
        return view('admin.package_sizes.create');
    }

    public function store(CreateRequest $request): RedirectResponse
    {
        $data = $request->validated();
        $data['is_active'] = (bool) ($request->boolean('is_active'));
        $data['sort_order'] = (int) ($data['sort_order'] ?? 0);

        $this->service->createPackageSize($data);

        return redirect()->route('admin.package-sizes.index')
            ->with('success', __('Package size created successfully.'));
    }

    public function show(PackageSize $packageSize): View
    {
        $packageSize->loadCount('packageShipments');

        return view('admin.package_sizes.show', compact('packageSize'));
    }

    public function edit(PackageSize $packageSize): View
    {
        return view('admin.package_sizes.edit', compact('packageSize'));
    }

    public function update(UpdateRequest $request, PackageSize $packageSize): RedirectResponse
    {
        $data = $request->validated();
        $data['is_active'] = (bool) ($request->boolean('is_active'));
        $data['sort_order'] = (int) ($data['sort_order'] ?? 0);

        $this->service->updatePackageSize($packageSize, $data);

        return redirect()->route('admin.package-sizes.index')
            ->with('success', __('Package size updated successfully.'));
    }

    public function destroy(PackageSize $packageSize): RedirectResponse
    {
        if ($packageSize->packageShipments()->exists()) {
            return redirect()->route('admin.package-sizes.index')
                ->with('error', __('Cannot delete package size that is already used in shipments.'));
        }

        $this->service->deletePackageSize($packageSize);

        return redirect()->route('admin.package-sizes.index')
            ->with('success', __('Package size deleted successfully.'));
    }
}

