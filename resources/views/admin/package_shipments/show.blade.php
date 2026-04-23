@extends('layouts.app')

@php
    $page = 'package-shipments';
@endphp

@section('title', __('Package Shipment Details'))

@section('content')
    <div class="container-fluid p-4 p-lg-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">{{ __('Dashboard') }}</a></li>
                        <li class="breadcrumb-item"><a href="{{ route('admin.package-shipments.index') }}">{{ __('Package Shipments') }}</a></li>
                        <li class="breadcrumb-item active">{{ __('Details') }}</li>
                    </ol>
                </nav>
                <h1 class="h3 mb-0">{{ __('Package Shipment') }} #{{ $shipment->id }}</h1>
            </div>
            <div class="d-flex gap-2">
                <a href="{{ route('admin.package-shipments.invoice', $shipment) }}" target="_blank" rel="noopener" class="btn btn-outline-primary">
                    <i class="bi bi-receipt me-2"></i>{{ __('Invoice') }}
                </a>
                <a href="{{ route('admin.package-shipments.index') }}" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-2"></i>{{ __('Back') }}
                </a>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">{{ __('Shipment Information') }}</h5>
                    </div>
                    <div class="card-body">
                        <dl class="row mb-0">
                            <dt class="col-sm-3">{{ __('Shipment ID') }}</dt>
                            <dd class="col-sm-9"><code>#{{ $shipment->id }}</code></dd>

                            <dt class="col-sm-3 mt-3">{{ __('Sender') }}</dt>
                            <dd class="col-sm-9 mt-3">
                                @if($shipment->sender)
                                    <strong>{{ $shipment->sender->name }}</strong><br>
                                    <small class="text-muted">{{ $shipment->sender->email }} | {{ $shipment->sender->phone }}</small>
                                @else
                                    <span class="text-muted">-</span>
                                @endif
                            </dd>

                            <dt class="col-sm-3 mt-3">{{ __('Receiver') }}</dt>
                            <dd class="col-sm-9 mt-3">
                                <strong>{{ $shipment->receiver_name }}</strong><br>
                                <small class="text-muted">{{ $shipment->receiver_phone }}</small>
                            </dd>

                            <dt class="col-sm-3 mt-3">{{ __('Pickup') }}</dt>
                            <dd class="col-sm-9 mt-3">
                                {{ $shipment->pickup_address }}<br>
                                <small class="text-muted">{{ $shipment->pickup_lat }}, {{ $shipment->pickup_lng }}</small>
                            </dd>

                            <dt class="col-sm-3 mt-3">{{ __('Dropoff') }}</dt>
                            <dd class="col-sm-9 mt-3">
                                {{ $shipment->dropoff_address }}<br>
                                <small class="text-muted">{{ $shipment->dropoff_lat }}, {{ $shipment->dropoff_lng }}</small>
                            </dd>

                            <dt class="col-sm-3 mt-3">{{ __('Size Snapshot') }}</dt>
                            <dd class="col-sm-9 mt-3">
                                {{ $shipment->package_size_name_snapshot }}
                                ({{ number_format($shipment->package_height_cm, 2) }} × {{ number_format($shipment->package_width_cm, 2) }} × {{ number_format($shipment->package_length_cm, 2) }} cm)
                                <br>
                                <small class="text-muted">{{ __('Multiplier') }}: {{ number_format($shipment->size_multiplier_snapshot, 2) }}</small>
                            </dd>

                            <dt class="col-sm-3 mt-3">{{ __('Distance') }}</dt>
                            <dd class="col-sm-9 mt-3">{{ number_format($shipment->distance_km, 2) }} km</dd>

                            <dt class="col-sm-3 mt-3">{{ __('Price') }}</dt>
                            <dd class="col-sm-9 mt-3">
                                <div>{{ __('Base') }}: {{ number_format($shipment->base_price, 2) }} {{ setting('currency', 'EGP') }}</div>
                                <div><strong>{{ __('Total') }}: {{ number_format($shipment->total_price, 2) }} {{ setting('currency', 'EGP') }}</strong></div>
                            </dd>

                            @if($shipment->package_image)
                                <dt class="col-sm-3 mt-3">{{ __('Package Image') }}</dt>
                                <dd class="col-sm-9 mt-3">
                                    <a href="{{ asset('storage/'.$shipment->package_image) }}" target="_blank" rel="noopener">
                                        <img src="{{ asset('storage/'.$shipment->package_image) }}" alt="{{ __('Package Image') }}" class="img-thumbnail" style="max-width: 220px;">
                                    </a>
                                </dd>
                            @endif
                        </dl>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="card-title mb-0">{{ __('Delivery Assignments') }}</h5>
                    </div>
                    <div class="card-body">
                        @if($shipment->assignments->count() > 0)
                            <div class="table-responsive">
                                <table class="table table-sm table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>{{ __('Assignment') }}</th>
                                            <th>{{ __('Delivery') }}</th>
                                            <th>{{ __('Status') }}</th>
                                            <th>{{ __('Assigned At') }}</th>
                                            <th>{{ __('Delivered At') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($shipment->assignments as $assignment)
                                            <tr>
                                                <td><code>#{{ $assignment->id }}</code></td>
                                                <td>
                                                    @if($assignment->delivery && $assignment->delivery->user)
                                                        {{ $assignment->delivery->user->name }}
                                                    @else
                                                        <span class="text-muted">-</span>
                                                    @endif
                                                </td>
                                                <td><span class="badge bg-secondary">{{ __(ucfirst(str_replace('_', ' ', $assignment->status))) }}</span></td>
                                                <td><small>{{ $assignment->assigned_at?->format('M d, Y H:i') ?? '-' }}</small></td>
                                                <td><small>{{ $assignment->delivered_at?->format('M d, Y H:i') ?? '-' }}</small></td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        @else
                            <p class="text-muted mb-0">{{ __('No assignments yet.') }}</p>
                        @endif
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">{{ __('Shipment Logs') }}</h5>
                    </div>
                    <div class="card-body">
                        @if($shipment->logs->count() > 0)
                            <div class="table-responsive">
                                <table class="table table-sm table-borderless mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>{{ __('Date') }}</th>
                                            <th>{{ __('User') }}</th>
                                            <th>{{ __('Type') }}</th>
                                            <th>{{ __('From') }}</th>
                                            <th>{{ __('To') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($shipment->logs as $log)
                                            <tr>
                                                <td><small class="text-muted">{{ $log->created_at->format('Y-m-d H:i') }}</small></td>
                                                <td><small>{{ $log->user->name ?? '-' }}</small></td>
                                                <td><small>{{ ucfirst(str_replace('_', ' ', $log->type)) }}</small></td>
                                                <td><small>{{ $log->from_status ?? '-' }}</small></td>
                                                <td><small>{{ $log->to_status ?? '-' }}</small></td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        @else
                            <p class="text-muted mb-0">{{ __('No logs for this shipment.') }}</p>
                        @endif
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card mb-3">
                    <div class="card-header">
                        <h5 class="card-title mb-0">{{ __('Current Status') }}</h5>
                    </div>
                    <div class="card-body">
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

                            $paymentClass = match($shipment->payment_status) {
                                'paid' => 'success',
                                'pending' => 'warning',
                                'failed' => 'danger',
                                'refunded' => 'secondary',
                                default => 'secondary',
                            };
                        @endphp
                        <p class="mb-3">
                            <span class="badge bg-{{ $statusClass }}">{{ __(ucfirst(str_replace('_', ' ', $shipment->status))) }}</span>
                        </p>
                        <p class="mb-2">
                            <strong>{{ __('Payment Status') }}:</strong>
                            <span class="badge bg-{{ $paymentClass }}">{{ __(ucfirst($shipment->payment_status)) }}</span>
                        </p>
                        <p class="mb-2"><strong>{{ __('Payment Method') }}:</strong> {{ $shipment->payment_method ?? '-' }}</p>
                        <p class="mb-2"><strong>{{ __('Wallet Used') }}:</strong> {{ number_format($shipment->wallet_used, 2) }} {{ setting('currency', 'EGP') }}</p>
                        <p class="mb-0"><strong>{{ __('Refunded Total') }}:</strong> {{ number_format($shipment->refunded_total, 2) }} {{ setting('currency', 'EGP') }}</p>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">{{ __('Timestamps') }}</h5>
                    </div>
                    <div class="card-body">
                        <p class="mb-2"><strong>{{ __('Created At') }}:</strong><br><small>{{ $shipment->created_at?->format('M d, Y H:i') }}</small></p>
                        <p class="mb-2"><strong>{{ __('Updated At') }}:</strong><br><small>{{ $shipment->updated_at?->format('M d, Y H:i') }}</small></p>
                        <p class="mb-0"><strong>{{ __('Paid At') }}:</strong><br><small>{{ $shipment->paid_at?->format('M d, Y H:i') ?? '-' }}</small></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
