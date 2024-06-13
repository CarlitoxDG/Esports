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
            'nombre' => ['required','min:2','max:255','unique:campeonatos,nombre'],
            'fecha_inicio' => ['required', 'date', 'after:yesterday'],
            'fecha_fin' => ['required', 'date', 'after:fecha_inicio'],
            'reglas' => ['required', 'string'],
            'premios' => ['required', 'string'],
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'El nombre del campeonato es obligatorio.',
            'nombre.min' => 'El nombre del campeonato debe tener al menos 2 caracteres.',
            'nombre.max' => 'El nombre del campeonato no puede superar los 255 caracteres.',
            'nombre.unique' => 'El nombre del campeonato ya existe. Elija otro nombre.',
            'fecha_inicio.required' => 'La fecha de inicio del campeonato es obligatoria.',
            'fecha_inicio.date' => 'La fecha de inicio del campeonato debe tener un formato válido (YYYY-MM-DD).',
            'fecha_inicio.after' => 'La fecha de inicio del campeonato debe ser posterior a ayer.',
            'fecha_fin.required' => 'La fecha de término del campeonato es obligatoria.',
            'fecha_fin.date' => 'La fecha de término del campeonato debe tener un formato válido (YYYY-MM-DD).',
            'fecha_fin.after' => 'La fecha de término del campeonato debe ser posterior a la fecha de inicio.',
            'reglas.required' => 'Las reglas del campeonato son obligatorias.',
            'reglas.string' => 'Las reglas del campeonato deben ser un texto.',
            'premios.required' => 'Los premios del campeonato son obligatorios.',
            'premios.string' => 'Los premios del campeonato deben ser un texto.',
        ];
    }
}
