<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EquipoRequest extends FormRequest
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
            'nombre' => ['required','string','min:3','max:50','unique:equipos,nombre',],
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
            'nombre.required' => 'El nombre del equipo es obligatorio.',
            'nombre.string' => 'El nombre del equipo debe ser un texto.',
            'nombre.min' => 'El nombre del equipo debe tener al menos 3 caracteres.',
            'nombre.max' => 'El nombre del equipo no puede superar los 50 caracteres.',
            'nombre.unique' => 'El nombre del equipo ya existe. Elija otro nombre.',
        ];
    }
}
