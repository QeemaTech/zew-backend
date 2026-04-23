<?php

namespace App\Http\Requests\Admin\PackageSizes;

use Illuminate\Foundation\Http\FormRequest;

class UpdateRequest extends FormRequest
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
            'name' => ['required', 'string', 'max:255'],
            'height_cm' => ['required', 'numeric', 'gt:0'],
            'width_cm' => ['required', 'numeric', 'gt:0'],
            'length_cm' => ['required', 'numeric', 'gt:0'],
            'size_multiplier' => ['required', 'numeric', 'gt:0'],
            'sort_order' => ['nullable', 'integer', 'min:0'],
            'is_active' => ['nullable', 'boolean'],
        ];
    }
}

