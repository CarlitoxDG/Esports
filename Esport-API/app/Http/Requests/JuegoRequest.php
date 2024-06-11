<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class JuegoRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'nombre' => ['required'],
            'categoria' => ['required'],
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'Indique el nombre del videojuego',
            'categoria.required' => 'Indique la categoria del juego',
        ];
    }
}
