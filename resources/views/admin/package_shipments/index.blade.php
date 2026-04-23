@extends('layouts.app')

@php
    $page = 'package-shipments';
@endphp

@section('title', __('Package Shipments'))

@section('content')
    <div class="container-fluid p-4 p-lg-4">
        @if(session('success'))
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>{{ session('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        @if(session('error'))
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle me-2"></i>{{ session('error') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">{{ __('Dashboard') }}</a></li>
                        <li class="breadcrumb-item active">{{ __('Package Shipments') }}</li>
                    </ol>
                </nav>
                <h1 class="h3 mb-0">{{ __('Package Shipments') }}</h1>
                <p class="text-muted mb-0">{{ __('Track user-to-user shipments and delivery progress') }}</p>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <form method="GET" action="{{ route('admin.package-shipments.index') }}" class="row g-3">
                    <div class="col-md-3">
                        <label for="search" class="form-label">{{ __('Search') }}</label>
                        <input type="text" class="form-control" id="search" name="search" value="{{ $filters['search'] ?? '' }}" placeholder="{{ __('ID, receiver, address...') }}">
                    </div>
                    <div class="col-md-2">
                        <label for="status" class="form-label">{{ __('Status') }}</label>
                        <select class="form-select" id="status" name="status">
                            <option value="">{{ __('All') }}</option>
                            @foreach(['pending', 'accepted', 'assigned', 'picked_up', 'in_transit', 'delivered', 'cancelled'] as $status)
                                <option value="{{ $status }}" {{ ($filters['status'] ?? '') === $status ? 'selected' : '' }}>{{ __(ucfirst(str_replace('_', ' ', $status))) }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="payment_status" class="form-label">{{ __('Payment') }}</label>
                        <select class="form-select" id="payment_status" name="payment_status">
                            <option value="">{{ __('All') }}</option>
                            @foreach(['pending', 'paid', 'failed', 'refunded'] as $paymentStatus)
                                <option value="{{ $paymentStatus }}" {{ ($filters['payment_status'] ?? '') === $paymentStatus ? 'selected' : '' }}>{{ __(ucfirst($paymentStatus)) }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="sender_id" class="form-label">{{ __('Sender ID') }}</label>
                        <input type="number" min="1" class="form-control" id="sender_id" name="sender_id" value="{{ $filters['sender_id'] ?? '' }}">
                    </div>
                    <div class="col-md-2">
                        <label for="receiver_phone" class="form-label">{{ __('Receiver Phone') }}</label>
                        <input type="text" class="form-control" id="receiver_phone" name="receiver_phone" value="{{ $filters['receiver_phone'] ?? '' }}">
                    </div>
                    <div class="col-12 d-flex flex-wrap gap-2 justify-content-end align-items-end">
                        <button type="submit" class="btn btn-outline-primary">{{ __('Filter') }}</button>
                        <a href="{{ route('admin.package-shipments.index') }}" class="btn btn-outline-secondary">{{ __('Reset') }}</a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                @if($packageShipments->count() > 0)
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>{{ __('Shipment') }}</th>
                                    <th>{{ __('Sender') }}</th>
                                    <th>{{ __('Receiver') }}</th>
                                    <th>{{ __('Distance') }}</th>
                                    <th>{{ __('Price') }}</th>
                                    <th>{{ __('Status') }}</th>
                                    <th>{{ __('Payment') }}</th>
                                    <th>{{ __('Created') }}</th>
                                    <th class="text-end">{{ __('Actions') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($packageShipments as $shipment)
                                    <tr>
                                        <td><code>#{{ $shipment->id }}</code></td>
                                        <td>
                                            @if($shipment->sender)
                                                {{ $shipment->sender->name }}<br>
                                                <small class="text-muted">ID: {{ $shipment->sender->id }}</small>
                                            @else
                                                <span class="text-muted">-</span>
                                            @endif
                                        </td>
                                        <td>
                                            <strong>{{ $shipment->receiver_name }}</strong><br>
                                            <small class="text-muted">{{ $shipment->receiver_phone }}</small>
                                        </td>
                                        <td>{{ number_format($shipment->distance_km, 2) }} km</td>
                                        <td>{{ number_format($shipment->total_price, 2) }} {{ setting('currency', 'EGP') }}</td>
                                        <td>
                                            @php
                                                $statusClass = match($shipment->status) {
                                                    'pending' => 'warning',
                                                    'accepted' => 'info',
                                                    'assigned' => 'primary',
                                                    'picked_up' => 'primary',
                                                    'in_transit' => 'primary',
                                                    'delivered' => 'success',
                                                    'cancelled' => 'danger',
                                                    default => 'secondary',
                                                };
                                            @endphp
                                            <span class="badge bg-{{ $statusClass }}">{{ __(ucfirst(str_replace('_', ' ', $shipment->status))) }}</span>
                                        </td>
                                        <td>
                                            @php
                                                $paymentClass = match($shipment->payment_status) {
                                                    'paid' => 'success',
                                                    'pending' => 'warning',
                                                    'failed' => 'danger',
                                                    'refunded' => 'secondary',
                                                    default => 'secondary',
                                                };
                                            @endphp
                                            <span class="badge bg-{{ $paymentClass }}">{{ __(ucfirst($shipment->payment_status)) }}</span>
                                        </td>
                                        <td><small class="text-muted">{{ $shipment->created_at?->format('M d, Y H:i') }}</small></td>
                                        <td class="text-end">
                                            <a href="{{ route('admin.package-shipments.show', $shipment) }}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-4">
                        {{ $packageShipments->links() }}
                    </div>
                @else
                    <div class="text-center py-5">
                        <i class="bi bi-truck fs-1 text-muted"></i>
                        <p class="text-muted mt-3">{{ __('No package shipments found.') }}</p>
                    </div>
                @endif
            </div>
        </div>
    </div>
@endsection
