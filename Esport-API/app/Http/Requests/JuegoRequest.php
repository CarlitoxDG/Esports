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
            'nombre' => ['required','min:3','max:50', 'unique:juegos,nombre'],
            'categoria' => ['required','min:2','max:30',],
        ];
    }

    /**
     * Get the validation messages that apply to the request.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'nombre.required' => 'El nombre del videojuego es obligatorio.',
            'nombre.min' => 'El nombre del videojuego debe tener al menos 3 caracteres.',
            'nombre.max' => 'El nombre del videojuego no puede superar los 50 caracteres.',
            'nombre.unique' => 'El nombre es inválido. Elija otro nombre.',
            'categoria.required' => 'La categoría del videojuego es obligatoria.',
            'categoria.min' => 'La categoría del videojuego debe tener al menos 2 caracteres.',
            'categoria.max' => 'La categoría del videojuego no puede superar los 30 caracteres.',
        ];
    }
}
