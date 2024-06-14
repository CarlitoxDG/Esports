<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ParticipanteRequest extends FormRequest
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
     * @return array<string, string> \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array{
        return [
            'nombre' => ['required','min:3','max:20'],
            'pais' => ['required','min:2','max:30'],
            'equipo_id' => ['required','integer','exists:equipos,id'],
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
            'nombre.required' => 'El nombre del jugador es obligatorio.',
            'nombre.min' => 'El nombre del jugador debe tener al menos 3 caracteres.',
            'nombre.max' => 'El nombre del jugador no puede superar los 20 caracteres.',
            'pais.required' => 'El país del jugador es obligatorio.',
            'pais.string' => 'El país del jugador debe ser un texto.',
            'pais.min' => 'El país del jugador debe tener al menos 2 caracteres.',
            'pais.max' => 'El país del jugador no puede superar los 30 caracteres.',
            'equipo_id.required' => 'El equipo del jugador es obligatorio.',
            'equipo_id.integer' => 'El equipo seleccionado no existe. Elija un equipo válido.',
            'equipo_id.exists' => 'El equipo seleccionado no existe. Elija un equipo válido.',
        ];
    }
}