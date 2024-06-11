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
            'fecha' => ['required'],
            'pais' => ['required'],
            'ciudad' => ['required'],
            'sede' => ['required'],
            'resultado' => ['nullable'],
            'campeonato_id' => ['required','integer','exists:campeonatos,id'],
            'equipo1_id' => ['required','integer','exists:equipos,id'],
            'equipo2_id' => ['required','integer','exists:equipos,id'],
        ];
    }

    public function messages(): array
    {
        return [
            'fecha.required' => 'Indique la fecha del partido',
            'pais.required' => 'Indique el pais',
            'ciudad.required' => 'Indique la ciudad',
            'sede.required' => 'Indique el nombre de la sede',
            'resultado.nullable' => '',
            'campeonato_id.required' => 'Campeonato no válido',
            'campeonato_id.integer' => 'Campeonato no válido',
            'campeonato_id.exists' => 'Campeonato no válido',
            'equipo1_id.required' => 'Equipo no válido',
            'equipo1_id.integer' => 'Equipo no válido',
            'equipo1_id.exists' => 'Equipo no válido',
            'equipo2_id.required' => 'Equipo no válido',
            'equipo2_id.integer' => 'Equipo no válido',
            'equipo2_id.exists' => 'Equipo no válido',
        ];
    }
}
