<?php

namespace App\Services;

use App\Models\Delivery;
use App\Models\PackageShipment;
use App\Models\PackageSize;
use App\Models\User;
use App\Models\WalletTransaction;
use App\Models\Zone;
use App\Notifications\PackageShipmentAvailableNotification;
use App\Repositories\PackageShipmentRepository;
use Illuminate\Http\UploadedFile;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class PackageShipmentService
{
    public function __construct(
        protected PackageShipmentRepository $packageShipmentRepository,
        protected NotificationService $notificationService
    ) {}

    /**
     * @param  array{
     *   search?: string,
     *   status?: string,
     *   payment_status?: string,
     *   sender_id?: int|string,
     *   receiver_phone?: string,
     * }  $filters
     */
    public function getPaginatedShipments(int $perPage = 15, array $filters = []): LengthAwarePaginator
    {
        return $this->packageShipmentRepository->getPaginatedShipments($perPage, $filters);
    }

    public function getShipmentById(int $id): ?PackageShipment
    {
        return $this->packageShipmentRepository->getShipmentById($id);
    }

    public function getShipmentByIdForSender(int $id, int $senderId): ?PackageShipment
    {
        return $this->packageShipmentRepository->getShipmentByIdForSender($id, $senderId);
    }

    /**
     * @param  array{
     *   status?: string,
     *   payment_status?: string,
     * }  $filters
     */
    public function getPaginatedForUser(int $userId, ?string $phone, int $perPage = 15, array $filters = []): LengthAwarePaginator
    {
        return $this->packageShipmentRepository->getPaginatedForUser($userId, $phone, $perPage, $filters);
    }

    public function getShipmentByIdForUser(int $id, int $userId, ?string $phone): ?PackageShipment
    {
        return $this->packageShipmentRepository->getShipmentByIdForUser($id, $userId, $phone);
    }

    public function getAvailableForDelivery(int $perPage = 15): LengthAwarePaginator
    {
        return $this->packageShipmentRepository->getAvailableForDelivery($perPage);
    }

    /**
     * @param  array{
     *   package_size_id: int,
     *   pickup_lat: float|int|string,
     *   pickup_lng: float|int|string,
     *   dropoff_lat: float|int|string,
     *   dropoff_lng: float|int|string,
     * }  $data
     * @return array{distance_km: float, price_per_km: float, base_price: float, size_multiplier: float, total_price: float}
     */
    public function calculatePrice(array $data): array
    {
        $packageSize = PackageSize::query()->findOrFail((int) $data['package_size_id']);
        $distanceKm = $this->distanceKm(
            (float) $data['pickup_lat'],
            (float) $data['pickup_lng'],
            (float) $data['dropoff_lat'],
            (float) $data['dropoff_lng']
        );

        $pricePerKm = (float) setting('shipping_price_per_km', 5);
        $basePrice = round($distanceKm * $pricePerKm, 2);
        $sizeMultiplier = (float) $packageSize->size_multiplier;
        $totalPrice = round($basePrice * $sizeMultiplier, 2);

        return [
            'distance_km' => $distanceKm,
            'price_per_km' => $pricePerKm,
            'base_price' => $basePrice,
            'size_multiplier' => $sizeMultiplier,
            'total_price' => $totalPrice,
        ];
    }

    /**
     * @param  array<string, mixed>  $data
     */
    public function createShipment(int $senderId, array $data): PackageShipment
    {
        return DB::transaction(function () use ($senderId, $data) {
            $packageSize = PackageSize::query()->findOrFail((int) $data['package_size_id']);
            $pricing = $this->calculatePrice([
                'package_size_id' => (int) $data['package_size_id'],
                'pickup_lat' => $data['pickup_lat'],
                'pickup_lng' => $data['pickup_lng'],
                'dropoff_lat' => $data['dropoff_lat'],
                'dropoff_lng' => $data['dropoff_lng'],
            ]);

            $imagePath = null;
            $packageImage = $data['package_image'] ?? null;
            if ($packageImage instanceof UploadedFile && $packageImage->isValid()) {
                $imagePath = $packageImage->store('package-shipments', 'public');
            }

            $pickupLat = (float) $data['pickup_lat'];
            $pickupLng = (float) $data['pickup_lng'];
            $dropoffLat = (float) $data['dropoff_lat'];
            $dropoffLng = (float) $data['dropoff_lng'];

            $pickupAddress = $this->resolveAddressFromCoordinates(
                $pickupLat,
                $pickupLng,
                (string) ($data['pickup_address'] ?? '')
            );
            $dropoffAddress = $this->resolveAddressFromCoordinates(
                $dropoffLat,
                $dropoffLng,
                (string) ($data['dropoff_address'] ?? '')
            );

            $shipment = $this->packageShipmentRepository->createShipment([
                'sender_id' => $senderId,
                'receiver_name' => (string) $data['receiver_name'],
                'receiver_phone' => (string) $data['receiver_phone'],
                'package_size_id' => (int) $data['package_size_id'],
                'pickup_address' => $pickupAddress,
                'pickup_lat' => $pickupLat,
                'pickup_lng' => $pickupLng,
                'dropoff_address' => $dropoffAddress,
                'dropoff_lat' => $dropoffLat,
                'dropoff_lng' => $dropoffLng,
                'package_image' => $imagePath,
                'package_size_name_snapshot' => (string) $packageSize->name,
                'package_height_cm' => (float) $packageSize->height_cm,
                'package_width_cm' => (float) $packageSize->width_cm,
                'package_length_cm' => (float) $packageSize->length_cm,
                'size_multiplier_snapshot' => (float) $packageSize->size_multiplier,
                'distance_km' => $pricing['distance_km'],
                'price_per_km' => $pricing['price_per_km'],
                'base_price' => $pricing['base_price'],
                'total_price' => $pricing['total_price'],
                'status' => PackageShipment::STATUS_PENDING,
                'payment_status' => PackageShipment::PAYMENT_PENDING,
                'notes' => $data['notes'] ?? null,
            ]);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $senderId,
                'type' => 'shipment_created',
                'from_status' => null,
                'to_status' => PackageShipment::STATUS_PENDING,
                'payload' => [
                    'distance_km' => $shipment->distance_km,
                    'total_price' => $shipment->total_price,
                ],
            ]);

            return $shipment;
        });
    }

    public function payShipment(PackageShipment $shipment, string $paymentMethod, bool $useWallet = false): PackageShipment
    {
        return DB::transaction(function () use ($shipment, $paymentMethod, $useWallet) {
            $shipment = PackageShipment::query()->lockForUpdate()->findOrFail($shipment->id);
            if ($shipment->payment_status === PackageShipment::PAYMENT_PAID) {
                return $shipment;
            }

            $sender = User::query()->lockForUpdate()->findOrFail((int) $shipment->sender_id);
            $walletUsed = 0.0;
            $totalPrice = (float) $shipment->total_price;
            $paymentMethod = strtolower(trim($paymentMethod));
            $isCash = $paymentMethod === 'cash';

            if ($isCash && $useWallet) {
                throw new \InvalidArgumentException(__('Wallet cannot be combined with cash payment.'));
            }

            if (! $isCash && $useWallet && $sender->wallet > 0) {
                $walletUsed = min((float) $sender->wallet, $totalPrice);
                $sender->wallet = round((float) $sender->wallet - $walletUsed, 2);
                $sender->save();

                WalletTransaction::query()->create([
                    'user_id' => $sender->id,
                    'type' => 'subtraction',
                    'amount' => $walletUsed,
                    'balance_after' => $sender->wallet,
                    'notes' => 'Wallet used for Package Shipment #'.$shipment->id,
                ]);
            }

            $fromPaymentStatus = (string) $shipment->payment_status;
            $newPaymentStatus = $isCash ? PackageShipment::PAYMENT_PENDING : PackageShipment::PAYMENT_PAID;
            $shipment->update([
                'payment_status' => $newPaymentStatus,
                'payment_method' => $paymentMethod,
                'wallet_used' => $walletUsed,
                'paid_at' => $isCash ? null : now(),
                'status' => $shipment->status === PackageShipment::STATUS_PENDING ? PackageShipment::STATUS_ACCEPTED : $shipment->status,
            ]);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $sender->id,
                'type' => 'payment_change',
                'from_status' => $fromPaymentStatus,
                'to_status' => $newPaymentStatus,
                'payload' => [
                    'payment_method' => $paymentMethod,
                    'wallet_used' => $walletUsed,
                ],
            ]);

            $shipment = $shipment->refresh();
            if ($shipment->status === PackageShipment::STATUS_ACCEPTED) {
                $this->notifyNearbyDeliveries($shipment);
            }

            return $shipment;
        });
    }

    public function cancelBySender(PackageShipment $shipment, int $senderId): PackageShipment
    {
        return DB::transaction(function () use ($shipment, $senderId) {
            $shipment = PackageShipment::query()->lockForUpdate()->findOrFail($shipment->id);
            if ((int) $shipment->sender_id !== $senderId) {
                throw new \InvalidArgumentException(__('You are not allowed to cancel this shipment.'));
            }

            if (! in_array($shipment->status, [PackageShipment::STATUS_PENDING, PackageShipment::STATUS_ACCEPTED], true)) {
                throw new \InvalidArgumentException(__('This shipment can no longer be cancelled.'));
            }

            $updateData = [
                'status' => PackageShipment::STATUS_CANCELLED,
            ];

            if ($shipment->payment_status === PackageShipment::PAYMENT_PAID) {
                $sender = User::query()->lockForUpdate()->findOrFail((int) $shipment->sender_id);
                $refundAmount = (float) $shipment->total_price;
                $sender->wallet = round((float) $sender->wallet + $refundAmount, 2);
                $sender->save();

                WalletTransaction::query()->create([
                    'user_id' => $sender->id,
                    'type' => 'addition',
                    'amount' => $refundAmount,
                    'balance_after' => $sender->wallet,
                    'notes' => 'Refund for cancelled Package Shipment #'.$shipment->id,
                ]);

                $updateData['payment_status'] = PackageShipment::PAYMENT_REFUNDED;
                $updateData['refund_status'] = 'refunded';
                $updateData['refunded_total'] = $refundAmount;
            }

            $shipment->update($updateData);

            $this->packageShipmentRepository->createLog([
                'package_shipment_id' => $shipment->id,
                'user_id' => $senderId,
                'type' => 'shipment_status_change',
                'from_status' => null,
                'to_status' => PackageShipment::STATUS_CANCELLED,
                'payload' => [
                    'payment_status' => $shipment->payment_status,
                ],
            ]);

            return $shipment->refresh();
        });
    }

    private function distanceKm(float $lat1, float $lon1, float $lat2, float $lon2): float
    {
        if (($lat1 === 0.0 && $lon1 === 0.0) || ($lat2 === 0.0 && $lon2 === 0.0)) {
            return 0.0;
        }

        $earthRadius = 6371;
        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);
        $a = sin($dLat / 2) ** 2 + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLon / 2) ** 2;
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

        return round($earthRadius * $c, 2);
    }

    private function resolveAddressFromCoordinates(float $lat, float $lng, string $providedAddress = ''): string
    {
        $providedAddress = trim($providedAddress);

        $apiKey = config('services.google.maps_api_key');

        if (! empty($apiKey)) {
            try {
                $response = Http::timeout(8)->get('https://maps.googleapis.com/maps/api/geocode/json', [
                    'latlng' => $lat.','.$lng,
                    'key' => $apiKey,
                ]);

                if ($response->successful()) {
                    $data = $response->json();
                    if (($data['status'] ?? null) === 'OK' && ! empty($data['results'][0]['formatted_address'])) {
                        return (string) $data['results'][0]['formatted_address'];
                    }
                }
            } catch (\Throwable $e) {
                Log::warning('PackageShipment reverse geocoding failed: '.$e->getMessage(), [
                    'provider' => 'google',
                    'lat' => $lat,
                    'lng' => $lng,
                ]);
            }
        }

        // Fallback to OpenStreetMap Nominatim when Google is unavailable/fails.
        try {
            $response = Http::timeout(8)
                ->withHeaders([
                    'User-Agent' => 'ZEW-Backend/1.0',
                    'Accept-Language' => app()->getLocale() === 'ar' ? 'ar' : 'en',
                ])
                ->get('https://nominatim.openstreetmap.org/reverse', [
                    'lat' => $lat,
                    'lon' => $lng,
                    'format' => 'jsonv2',
                    'addressdetails' => 1,
                ]);

            if ($response->successful()) {
                $data = $response->json();
                if (! empty($data['display_name']) && is_string($data['display_name'])) {
                    return $data['display_name'];
                }
            }
        } catch (\Throwable $e) {
            Log::warning('PackageShipment reverse geocoding failed: '.$e->getMessage(), [
                'provider' => 'nominatim',
                'lat' => $lat,
                'lng' => $lng,
            ]);
        }

        // If caller provided a human-readable address, keep it.
        if ($providedAddress !== '' && ! $this->looksLikeCoordinates($providedAddress)) {
            return $providedAddress;
        }

        return $this->formatCoordinates($lat, $lng);
    }

    private function formatCoordinates(float $lat, float $lng): string
    {
        return number_format($lat, 6, '.', '').', '.number_format($lng, 6, '.', '');
    }

    private function looksLikeCoordinates(string $value): bool
    {
        return (bool) preg_match('/^\s*-?\d+(\.\d+)?\s*,\s*-?\d+(\.\d+)?\s*$/', $value);
    }

    private function notifyNearbyDeliveries(PackageShipment $shipment): void
    {
        $pickup = [
            'lat' => (float) $shipment->pickup_lat,
            'lng' => (float) $shipment->pickup_lng,
        ];

        $zones = Zone::query()
            ->active()
            ->with(['deliveries' => fn ($q) => $q->active()->with('user')])
            ->get();

        $deliveryUsers = $zones
            ->filter(fn (Zone $zone) => $zone->containsPoint($pickup))
            ->flatMap(function (Zone $zone) {
                return $zone->deliveries;
            })
            ->filter(fn (Delivery $delivery) => $delivery->user && $delivery->user->is_active)
            ->map(fn (Delivery $delivery) => $delivery->user)
            ->unique('id')
            ->values();

        $this->notifyDeliveryUsers($deliveryUsers, $shipment);
    }

    /**
     * @param  Collection<int, User>  $deliveryUsers
     */
    private function notifyDeliveryUsers(Collection $deliveryUsers, PackageShipment $shipment): void
    {
        $notification = new PackageShipmentAvailableNotification($shipment);
        foreach ($deliveryUsers as $user) {
            $this->notificationService->notifyUser($user, $notification);
        }
    }
}
