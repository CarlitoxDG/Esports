<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CampeonatoRequest extends FormRequest
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
            'fecha_inicio' => ['required'],
            'fecha_fin' => ['required'],
            'reglas' => ['required'],
            'premios' => ['required'],
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'Indique el nombre',
            'fecha_inicio.required' => 'Indique la fecha de inicio',
            'fecha_fin.required' => 'Indique la fecha de termino',
            'reglas.required' => 'Indique la(s) regla(s)',
            'premios.required' => 'Indique el/los premio(s)',
        ];
    }
}
