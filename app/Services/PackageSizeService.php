<?php

namespace App\Services;

use App\Models\PackageSize;
use App\Repositories\PackageSizeRepository;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

class PackageSizeService
{
    public function __construct(
        protected PackageSizeRepository $packageSizeRepository
    ) {}

    public function getActiveSizes(): Collection
    {
        return $this->packageSizeRepository->getActiveSizes();
    }

    /**
     * @param  array{search?: string, is_active?: string|bool}  $filters
     */
    public function getPaginatedPackageSizes(int $perPage = 15, array $filters = []): LengthAwarePaginator
    {
        return $this->packageSizeRepository->getPaginatedPackageSizes($perPage, $filters);
    }

    public function getPackageSizeById(int $id): ?PackageSize
    {
        return $this->packageSizeRepository->getPackageSizeById($id);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function createPackageSize(array $data): PackageSize
    {
        return $this->packageSizeRepository->createPackageSize($data);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function updatePackageSize(PackageSize $packageSize, array $data): bool
    {
        return $this->packageSizeRepository->updatePackageSize($packageSize, $data);
    }

    public function deletePackageSize(PackageSize $packageSize): bool
    {
        return $this->packageSizeRepository->deletePackageSize($packageSize);
    }
}

