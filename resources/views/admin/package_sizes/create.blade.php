@extends('layouts.app')

@php
    $page = 'package-sizes';
@endphp

@section('title', __('Create Package Size'))

@section('content')
    <div class="container-fluid p-4 p-lg-4">
        @if($errors->any())
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle me-2"></i>
                <ul class="mb-0">
                    @foreach($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">{{ __('Dashboard') }}</a></li>
                        <li class="breadcrumb-item"><a href="{{ route('admin.package-sizes.index') }}">{{ __('Package Sizes') }}</a></li>
                        <li class="breadcrumb-item active">{{ __('Create Package Size') }}</li>
                    </ol>
                </nav>
                <h1 class="h3 mb-0">{{ __('Create Package Size') }}</h1>
                <p class="text-muted mb-0">{{ __('Add a standard package size for shipping calculation') }}</p>
            </div>
            <a href="{{ route('admin.package-sizes.index') }}" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-2"></i>{{ __('Back') }}
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <form action="{{ route('admin.package-sizes.store') }}" method="POST">
                    @csrf

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label" for="name">{{ __('Name') }} *</label>
                            <input type="text" id="name" name="name" class="form-control @error('name') is-invalid @enderror" value="{{ old('name') }}" required>
                            @error('name')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="col-md-3">
                            <label class="form-label" for="sort_order">{{ __('Sort Order') }}</label>
                            <input type="number" min="0" id="sort_order" name="sort_order" class="form-control @error('sort_order') is-invalid @enderror" value="{{ old('sort_order', 0) }}">
                            @error('sort_order')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="col-md-3">
                            <label class="form-label" for="size_multiplier">{{ __('Size Multiplier') }} *</label>
                            <input type="number" step="0.01" min="0.01" id="size_multiplier" name="size_multiplier" class="form-control @error('size_multiplier') is-invalid @enderror" value="{{ old('size_multiplier', 1) }}" required>
                            @error('size_multiplier')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="col-md-4">
                            <label class="form-label" for="height_cm">{{ __('Height (cm)') }} *</label>
                            <input type="number" step="0.01" min="0.01" id="height_cm" name="height_cm" class="form-control @error('height_cm') is-invalid @enderror" value="{{ old('height_cm') }}" required>
                            @error('height_cm')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="col-md-4">
                            <label class="form-label" for="width_cm">{{ __('Width (cm)') }} *</label>
                            <input type="number" step="0.01" min="0.01" id="width_cm" name="width_cm" class="form-control @error('width_cm') is-invalid @enderror" value="{{ old('width_cm') }}" required>
                            @error('width_cm')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="col-md-4">
                            <label class="form-label" for="length_cm">{{ __('Length (cm)') }} *</label>
                            <input type="number" step="0.01" min="0.01" id="length_cm" name="length_cm" class="form-control @error('length_cm') is-invalid @enderror" value="{{ old('length_cm') }}" required>
                            @error('length_cm')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    <div class="form-check form-switch mt-4 mb-4">
                        <input class="form-check-input" type="checkbox" id="is_active" name="is_active" value="1" {{ old('is_active', true) ? 'checked' : '' }}>
                        <label class="form-check-label" for="is_active">{{ __('Active') }}</label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="{{ route('admin.package-sizes.index') }}" class="btn btn-outline-secondary">{{ __('Cancel') }}</a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle me-2"></i>{{ __('Create Package Size') }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

