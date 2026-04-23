<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ __('Package Shipment Invoice') }} - #{{ $shipment->id }}</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; color: #1f2937; background: #ffffff; }
        .page { max-width: 920px; margin: 0 auto; padding: 32px 28px 40px; }
        .no-print { display: flex; gap: 12px; align-items: center; justify-content: space-between; margin-bottom: 20px; }
        .btn { display: inline-flex; align-items: center; justify-content: center; padding: 10px 14px; border-radius: 10px; border: 1px solid #e5e7eb; background: #fff; color: #1f2937; text-decoration: none; font-size: 14px; line-height: 1; }
        .btn:hover { background: #f8fafc; }
        .card { border: 1px solid #e5e7eb; padding: 22px; }
        .header { text-align: center; margin-bottom: 18px; }
        .logo { height: 56px; object-fit: contain; margin-bottom: 8px; }
        .title { margin: 6px 0 0; font-size: 22px; font-weight: 700; }
        .info { margin-bottom: 16px; }
        .info-table { width: 100%; border-collapse: collapse; font-size: 14px; margin-top: 0; }
        .info-table td { padding: 6px 0; border: none; vertical-align: middle; }
        .info-table td:last-child { text-align: right; }
        .muted { color: #6b7280; }
        .block-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; margin: 18px 0; font-size: 14px; }
        .label-box { background: #e8edff; padding: 10px 15px; font-weight: 700; color: #1f2937; font-size: 13px; margin-bottom: 8px; width: fit-content; }
        .address-block { padding: 10px 0 0; line-height: 1.6; }
        table { width: 100%; border-collapse: collapse; margin-top: 8px; }
        thead th { background: #e8edff; font-weight: 700; text-align: left; font-size: 13px; padding: 10px; border: 1px solid #e5e7eb; }
        tbody td { font-size: 13px; padding: 10px; border: 1px solid #e5e7eb; vertical-align: top; }
        .text-end { text-align: right; }
        .text-center { text-align: center; }
        .totals { width: 100%; margin-top: 18px; border-radius: 10px; overflow: hidden; border: 1px solid #e5e7eb; }
        .totals-row { display: grid; grid-template-columns: 1fr 0.2fr 1fr 1fr 1fr; padding: 10px 12px; font-size: 13px; align-items: center; }
        .totals-row:nth-child(odd) { background: #e8edff; }
        .totals-row:nth-child(even) { background: #f8fafc; }
        @media print {
            .no-print { display: none !important; }
            .page { padding: 0 0 12px; max-width: none; }
            .card { border: none; padding: 0; }
            a[href]:after { content: ""; }
        }
    </style>
</head>

<body>
    <div class="page">
        @if (empty($asPdf))
            <div class="no-print">
                <div class="muted">{{ __('Print to PDF from your browser (Ctrl+P).') }}</div>
                <a class="btn" href="{{ route('admin.package-shipments.show', $shipment->id) }}">{{ __('Back') }}</a>
            </div>
        @endif

        <div class="card">
            <div class="header">
                @php $logo = setting('app_logo'); @endphp
                @if ($logo)
                    <img src="{{ asset('storage/' . $logo) }}" alt="{{ config('app.name') }}" class="logo">
                @endif
                <h1 class="title">{{ __('Package Shipment Invoice') }}</h1>
            </div>

            <div class="info">
                <table class="info-table">
                    <tr>
                        <td>
                            <strong>{{ __('Invoice ID') }}:</strong>
                            <span class="muted">#{{ $shipment->id }}</span>
                        </td>
                        <td>
                            <strong>{{ __('Shipment Date') }}:</strong>
                            <span class="muted">{{ optional($shipment->created_at)->format('d-m-Y') }}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>{{ __('Shipment Status') }}:</strong>
                            <span class="muted">{{ ucfirst(str_replace('_', ' ', $shipment->status)) }}</span>
                        </td>
                        <td>
                            <strong>{{ __('Payment Status') }}:</strong>
                            <span class="muted">{{ ucfirst($shipment->payment_status) }}</span>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="block-grid">
                <div>
                    <div class="label-box">{{ __('Sender') }}</div>
                    <div class="address-block">
                        <strong>{{ $shipment->sender->name ?? '-' }}</strong><br>
                        {{ __('Phone') }}: {{ $shipment->sender->phone ?? '-' }}<br>
                        {{ __('Email') }}: {{ $shipment->sender->email ?? '-' }}<br>
                        {{ __('Pickup Address') }}:<br>
                        {{ $shipment->pickup_address ?? '-' }}
                    </div>
                </div>
                <div>
                    <div class="label-box">{{ __('Receiver') }}</div>
                    <div class="address-block">
                        <strong>{{ $shipment->receiver_name }}</strong><br>
                        {{ __('Phone') }}: {{ $shipment->receiver_phone }}<br>
                        {{ __('Dropoff Address') }}:<br>
                        {{ $shipment->dropoff_address ?? '-' }}<br>
                        <span class="muted">{{ $shipment->dropoff_lat }}, {{ $shipment->dropoff_lng }}</span>
                    </div>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>{{ __('Package') }}</th>
                        <th>{{ __('Dimensions (cm)') }}</th>
                        <th class="text-end">{{ __('Distance (km)') }}</th>
                        <th class="text-end">{{ __('Price / km') }}</th>
                        <th class="text-end">{{ __('Base Price') }}</th>
                        <th class="text-end">{{ __('Total') }}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            {{ $shipment->package_size_name_snapshot }}<br>
                            @if($shipment->package_image)
                                <span class="muted">{{ __('Image attached') }}</span>
                            @endif
                        </td>
                        <td>
                            {{ number_format($shipment->package_height_cm, 2) }} ×
                            {{ number_format($shipment->package_width_cm, 2) }} ×
                            {{ number_format($shipment->package_length_cm, 2) }}
                        </td>
                        <td class="text-end">{{ number_format($shipment->distance_km, 2) }}</td>
                        <td class="text-end">{{ number_format($shipment->price_per_km, 2) }} {{ setting('currency', 'EGP') }}</td>
                        <td class="text-end">{{ number_format($shipment->base_price, 2) }} {{ setting('currency', 'EGP') }}</td>
                        <td class="text-end"><strong>{{ number_format($shipment->total_price, 2) }} {{ setting('currency', 'EGP') }}</strong></td>
                    </tr>
                </tbody>
            </table>

            <div class="totals">
                <div class="totals-row">
                    <span class="muted">{{ __('Distance') }}</span><span>:</span><span></span><span></span>
                    <strong>{{ number_format($shipment->distance_km, 2) }} km</strong>
                </div>
                <div class="totals-row">
                    <span class="muted">{{ __('Size Multiplier') }}</span><span>:</span><span></span><span></span>
                    <strong>{{ number_format($shipment->size_multiplier_snapshot, 2) }}</strong>
                </div>
                <div class="totals-row">
                    <span class="muted">{{ __('Base Price') }}</span><span>:</span><span></span><span></span>
                    <strong>{{ number_format($shipment->base_price, 2) }} {{ setting('currency', 'EGP') }}</strong>
                </div>
                <div class="totals-row">
                    <strong>{{ __('Grand Total') }}</strong><span>:</span><span></span><span></span>
                    <strong>{{ number_format($shipment->total_price, 2) }} {{ setting('currency', 'EGP') }}</strong>
                </div>
            </div>
        </div>
    </div>
</body>

</html>

