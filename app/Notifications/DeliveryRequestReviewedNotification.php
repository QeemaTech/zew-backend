<?php

namespace App\Notifications;

use App\Models\DeliveryRequest;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class DeliveryRequestReviewedNotification extends Notification
{
    use Queueable;

    public function __construct(
        public DeliveryRequest $deliveryRequest
    ) {}

    /**
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $isAccepted = $this->deliveryRequest->status === 'accepted';

        if ($isAccepted) {
            return (new MailMessage)
                ->subject(__('Your delivery request has been accepted'))
                ->greeting(__('Hello :name,', ['name' => $notifiable->name ?? __('there')]))
                ->line(__('Your request to become a delivery person has been accepted.'))
                ->line(__('Before your first login, please reset your password from the application.'))
                ->line(__('Use the "Forgot Password" / "Reset Password" flow, then sign in with the new password.'))
                ->action(__('Reset Password'), url('/forgot-password'));
        }

        $mail = (new MailMessage)
            ->subject(__('Your delivery request has been rejected'))
            ->greeting(__('Hello :name,', ['name' => $notifiable->name ?? __('there')]))
            ->line(__('Your request to become a delivery person has been rejected.'));

        if (! empty($this->deliveryRequest->rejection_reason)) {
            $mail->line(__('Reason: :reason', ['reason' => $this->deliveryRequest->rejection_reason]));
        }

        return $mail;
    }

    /**
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $isAccepted = $this->deliveryRequest->status === 'accepted';

        return [
            'delivery_request_id' => $this->deliveryRequest->id,
            'status' => $this->deliveryRequest->status,
            'title' => $isAccepted
                ? __('Your delivery request has been accepted')
                : __('Your delivery request has been rejected'),
            'message' => $isAccepted
                ? __('Your request to become a delivery person was accepted.')
                : __('Your request to become a delivery person was rejected.'),
            'rejection_reason' => $this->deliveryRequest->rejection_reason,
        ];
    }
}
