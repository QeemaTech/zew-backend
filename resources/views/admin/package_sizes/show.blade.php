@extends('layouts.app')

@php
    $page = 'package-sizes';
@endphp

@section('title', __('Package Size Details'))

@section('content')
    <div class="container-fluid p-4 p-lg-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">{{ __('Dashboard') }}</a></li>
                        <li class="breadcrumb-item"><a href="{{ route('admin.package-sizes.index') }}">{{ __('Package Sizes') }}</a></li>
                        <li class="breadcrumb-item active">{{ __('Details') }}</li>
                    </ol>
                </nav>
                <h1 class="h3 mb-0">{{ __('Package Size') }}: {{ $packageSize->name }}</h1>
            </div>
            <div class="d-flex gap-2">
                <a href="{{ route('admin.package-sizes.edit', $packageSize) }}" class="btn btn-primary">
                    <i class="bi bi-pencil me-2"></i>{{ __('Edit') }}
                </a>
                <a href="{{ route('admin.package-sizes.index') }}" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-2"></i>{{ __('Back') }}
                </a>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <dl class="row mb-0">
                    <dt class="col-sm-3">{{ __('Name') }}</dt>
                    <dd class="col-sm-9">{{ $packageSize->name }}</dd>

                    <dt class="col-sm-3 mt-3">{{ __('Height (cm)') }}</dt>
                    <dd class="col-sm-9 mt-3">{{ number_format($packageSize->height_cm, 2) }}</dd>

                    <dt class="col-sm-3 mt-3">{{ __('Width (cm)') }}</dt>
                    <dd class="col-sm-9 mt-3">{{ number_format($packageSize->width_cm, 2) }}</dd>

                    <dt class="col-sm-3 mt-3">{{ __('Length (cm)') }}</dt>
                    <dd class="col-sm-9 mt-3">{{ number_format($packageSize->length_cm, 2) }}</dd>

                    <dt class="col-sm-3 mt-3">{{ __('Size Multiplier') }}</dt>
                    <dd class="col-sm-9 mt-3">
                        <span class="badge bg-info">{{ number_format($packageSize->size_multiplier, 2) }}</span>
                    </dd>

                    <dt class="col-sm-3 mt-3">{{ __('Sort Order') }}</dt>
                    <dd class="col-sm-9 mt-3">{{ $packageSize->sort_order }}</dd>

                    <dt class="col-sm-3 mt-3">{{ __('Status') }}</dt>
                    <dd class="col-sm-9 mt-3">
                        @if($packageSize->is_active)
                            <span class="badge bg-success">{{ __('Active') }}</span>
                        @else
                            <span class="badge bg-secondary">{{ __('Inactive') }}</span>
                        @endif
                    </dd>

                    <dt class="col-sm-3 mt-3">{{ __('Used In Shipments') }}</dt>
                    <dd class="col-sm-9 mt-3">
                        <span class="badge bg-secondary">{{ $packageSize->package_shipments_count }}</span>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
@endsection

