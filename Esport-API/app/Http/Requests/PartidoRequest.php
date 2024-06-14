<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PartidoRequest extends FormRequest
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
            'fecha' => ['required', 'date','after:yesterday'],
            'pais' => ['required', 'string', 'min:2', 'max:50'],
            'ciudad' => ['required', 'string', 'min:2', 'max:60'],
            'sede' => ['required', 'min:2', 'max:60'],
            'resultado' => ['nullable'],
            'campeonato_id' => ['required', 'integer', 'exists:campeonatos,id'],
            'equipo1_id' => ['required', 'integer', 'different:equipo2_id', 'exists:equipos,id'],
            'equipo2_id' => ['required', 'integer', 'different:equipo1_id', 'exists:equipos,id'],
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
            'fecha.required' => 'La fecha del partido es obligatoria.',
            'fecha.date' => 'La fecha del partido debe tener un formato válido (YYYY-MM-DD).',
            'fecha.after' => 'La fecha del partido debe ser posterior a ayer.',
            'pais.required' => 'El país del partido es obligatorio.',
            'pais.string' => 'El país del partido debe ser un texto.',
            'pais.min' => 'El país del partido debe tener al menos 2 caracteres.',
            'pais.max' => 'El país del partido no puede superar los 50 caracteres.',
            'ciudad.required' => 'La ciudad del partido es obligatoria.',
            'ciudad.string' => 'La ciudad del partido debe ser un texto.',
            'ciudad.min' => 'La ciudad del partido debe tener al menos 2 caracteres.',
            'ciudad.max' => 'La ciudad del partido no puede superar los 60 caracteres.',
            'sede.required' => 'La sede del partido es obligatoria.',
            'sede.string' => 'La sede del partido debe ser un texto.',
            'sede.min' => 'La sede del partido debe tener al menos 2 caracteres.',
            'sede.max' => 'La sede del partido no puede superar los 60 caracteres.',
            'resultado.nullable' => 'El resultado del partido puede ser opcional.',
            'campeonato_id.required' => 'El campeonato del partido es obligatorio.',
            'campeonato_id.integer' => 'El campeonato seleccionado no existe. Elija un campeonato válido.',
            'campeonato_id.exists' => 'El campeonato seleccionado no existe. Elija un campeonato válido.',
            'equipo1_id.required' => 'El equipo 1 del partido es obligatorio.',
            'equipo1_id.integer' => 'El equipo 1 seleccionado no existe. Elija un equipo válido.',
            'equipo1_id.different' => 'El equipo 1 no puede ser el mismo que el equipo 2.',
            'equipo1_id.exists' => 'El equipo 1 seleccionado no existe. Elija un equipo válido.',
            'equipo2_id.required' => 'El equipo 2 del partido es obligatorio.',
            'equipo2_id.integer' => 'El equipo 2 seleccionado no existe. Elija un equipo válido.',
            'equipo2_id.different' => 'El equipo 2 no puede ser el mismo que el equipo 1.',
            'equipo2_id.exists' => 'El equipo 2 seleccionado no existe. Elija un equipo válido.',
        ];
    }
}
