<?php

namespace App\Http\Requests\Api\PackageShipments;

use Illuminate\Foundation\Http\FormRequest;

class PayRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'payment_method' => ['required', 'string', 'max:50'],
            'use_wallet' => ['nullable', 'boolean'],
        ];
    }
}

