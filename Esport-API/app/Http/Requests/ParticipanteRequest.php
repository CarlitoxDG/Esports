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
        return false;
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
            'pais' => ['required'],
            'equipo_id' => ['required','integer','exists:equipos,id'],
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'Indique el nombre',
            'pais.required' => 'Indique el pais del jugador',
            'equipo_id.required' => 'Indique el equipo al cual pertenece',
            'equipo_id.integer' => 'Equipo no válido',
            'equipo_id.exists' => 'Equipo no válido',

        ];
    }
}
