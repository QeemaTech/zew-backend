<?php

namespace App\Notifications;

use App\Models\PackageShipment;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class PackageShipmentAvailableNotification extends Notification
{
    use Queueable;

    public function __construct(
        public PackageShipment $shipment
    ) {}

    /**
     * @param  mixed  $notifiable
     * @return array<int, string>
     */
    public function via($notifiable): array
    {
        return ['database'];
    }

    /**
     * @param  mixed  $notifiable
     */
    public function toMail($notifiable): MailMessage
    {
        return (new MailMessage)
            ->line(__('A new package shipment is available near your pickup area.'))
            ->line(__('Shipment #:id', ['id' => $this->shipment->id]));
    }

    /**
     * @param  mixed  $notifiable
     * @return array<string, mixed>
     */
    public function toArray($notifiable): array
    {
        return [
            'type' => 'package_shipment_available',
            'package_shipment_id' => $this->shipment->id,
            'pickup_address' => $this->shipment->pickup_address,
            'dropoff_address' => $this->shipment->dropoff_address,
            'total_price' => (float) $this->shipment->total_price,
            'distance_km' => (float) $this->shipment->distance_km,
        ];
    }
}

