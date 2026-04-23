<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\PackageShipment;
use App\Services\PackageShipmentService;
use Illuminate\Http\Request;
use Illuminate\View\View;
use niklasravnsborg\LaravelPdf\Facades\Pdf as PDF;

class PackageShipmentController extends Controller
{
    public function __construct(
        protected PackageShipmentService $service
    ) {}

    public function index(Request $request): View
    {
        $perPage = (int) $request->get('per_page', 15);
        $filters = [
            'search' => (string) $request->get('search', ''),
            'status' => (string) $request->get('status', ''),
            'payment_status' => (string) $request->get('payment_status', ''),
            'sender_id' => $request->get('sender_id', ''),
            'receiver_phone' => (string) $request->get('receiver_phone', ''),
        ];

        $packageShipments = $this->service->getPaginatedShipments($perPage, $filters);

        return view('admin.package_shipments.index', compact('packageShipments', 'filters'));
    }

    public function show(PackageShipment $packageShipment): View
    {
        $shipment = $this->service->getShipmentById((int) $packageShipment->id);
        if (! $shipment) {
            abort(404, __('Package shipment not found.'));
        }

        return view('admin.package_shipments.show', compact('shipment'));
    }

    /**
     * Download or view package shipment invoice as PDF.
     */
    public function invoice(PackageShipment $packageShipment)
    {
        $shipment = $this->service->getShipmentById((int) $packageShipment->id);
        if (! $shipment) {
            abort(404, __('Package shipment not found.'));
        }

        $shipment->loadMissing([
            'sender',
            'packageSize',
            'assignments.delivery.user',
        ]);

        $pdf = PDF::loadView('admin.package_shipments.invoice', [
            'shipment' => $shipment,
            'asPdf' => true,
        ]);

        return $pdf->stream('package-shipment-invoice-'.$shipment->id.'.pdf');
    }
}
