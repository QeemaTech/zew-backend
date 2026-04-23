<?php

namespace App\Repositories;

use App\Models\PackageSize;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

class PackageSizeRepository
{
    public function getActiveSizes(): Collection
    {
        return PackageSize::query()
            ->active()
            ->orderBy('sort_order')
            ->orderBy('id')
            ->get();
    }

    /**
     * @param  array{search?: string, is_active?: string|bool}  $filters
     */
    public function getPaginatedPackageSizes(int $perPage = 15, array $filters = []): LengthAwarePaginator
    {
        $query = PackageSize::query();

        if (! empty($filters['search'])) {
            $search = trim((string) $filters['search']);
            $query->where('name', 'like', "%{$search}%");
        }

        if (isset($filters['is_active']) && $filters['is_active'] !== '') {
            $isActive = filter_var($filters['is_active'], FILTER_VALIDATE_BOOLEAN);
            $query->where('is_active', $isActive);
        }

        return $query->orderBy('sort_order')->orderBy('id')->paginate($perPage);
    }

    public function getPackageSizeById(int $id): ?PackageSize
    {
        return PackageSize::query()->find($id);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function createPackageSize(array $data): PackageSize
    {
        return PackageSize::query()->create($data);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function updatePackageSize(PackageSize $packageSize, array $data): bool
    {
        return $packageSize->update($data);
    }

    public function deletePackageSize(PackageSize $packageSize): bool
    {
        return $packageSize->delete();
    }
}

