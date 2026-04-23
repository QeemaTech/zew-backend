@if($packageSizes->count() > 0)
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>{{ __('Name') }}</th>
                    <th>{{ __('Dimensions (cm)') }}</th>
                    <th>{{ __('Multiplier') }}</th>
                    <th>{{ __('Sort') }}</th>
                    <th>{{ __('Status') }}</th>
                    <th class="text-end">{{ __('Actions') }}</th>
                </tr>
            </thead>
            <tbody>
                @foreach($packageSizes as $packageSize)
                    <tr>
                        <td><strong>{{ $packageSize->name }}</strong></td>
                        <td>{{ number_format($packageSize->height_cm, 2) }} × {{ number_format($packageSize->width_cm, 2) }} × {{ number_format($packageSize->length_cm, 2) }}</td>
                        <td>
                            <span class="badge bg-info">{{ number_format($packageSize->size_multiplier, 2) }}</span>
                        </td>
                        <td>{{ $packageSize->sort_order }}</td>
                        <td>
                            @if($packageSize->is_active)
                                <span class="badge bg-success">{{ __('Active') }}</span>
                            @else
                                <span class="badge bg-secondary">{{ __('Inactive') }}</span>
                            @endif
                        </td>
                        <td class="text-end">
                            <div class="btn-group" role="group">
                                <a href="{{ route('admin.package-sizes.show', $packageSize) }}" class="btn btn-sm btn-outline-info" data-bs-toggle="tooltip" title="{{ __('View') }}">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="{{ route('admin.package-sizes.edit', $packageSize) }}" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="{{ __('Edit') }}">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button type="button"
                                        class="btn btn-sm btn-outline-danger delete-package-size-btn"
                                        data-id="{{ $packageSize->id }}"
                                        data-label="{{ e($packageSize->name) }}"
                                        data-bs-toggle="tooltip"
                                        title="{{ __('Delete') }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    <div class="mt-4">
        {{ $packageSizes->links() }}
    </div>
@else
    <div class="text-center py-5">
        <i class="bi bi-box-seam fs-1 text-muted"></i>
        <p class="text-muted mt-3">{{ __('No package sizes found.') }}</p>
        <a href="{{ route('admin.package-sizes.create') }}" class="btn btn-primary mt-2">
            <i class="bi bi-plus-lg me-2"></i>{{ __('Add Your First Package Size') }}
        </a>
    </div>
@endif

