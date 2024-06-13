<?php

namespace App\Http\Controllers;

use App\Models\Campeonato;
use Illuminate\Http\Request;
use App\Http\Requests\CampeonatoRequest;

class CampeonatosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Campeonato::all();
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $campeonato = new Campeonato();
        $campeonato->nombre = $request->nombre;
        $campeonato->fecha_inicio = $request->fecha_inicio;
        $campeonato->fecha_fin = $request->fecha_fin;
        $campeonato->reglas = $request->reglas;
        $campeonato->premios = $request->premios;
        $campeonato->save();
        return $campeonato;
    }

    /**
     * Display the specified resource.
     */
    public function show(Campeonato $campeonato)
    {
        return $campeonato;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Campeonato $campeonato)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(CampeonatoRequest $request, Campeonato $campeonato)
    {
        $campeonato->nombre = $request->nombre;
        $campeonato->fecha_inicio = $request->fecha_inicio;
        $campeonato->fecha_fin = $request->fecha_fin;
        $campeonato->reglas = $request->reglas;
        $campeonato->premios = $request->premios;
        $campeonato->save();
        return $campeonato;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Campeonato $campeonato)
    {
        return $campeonato->delete();
    }

    public function equiposEnCampeonato($id)
    {
        $campeonato = Campeonato::find($id);

        if (!$campeonato) {
            return response()->json(['error' => 'Campeonato no encontrado'], 404);
        }

        $equipos = collect([]);

        foreach ($campeonato->partidos as $partido) {
            $equipos->push($partido->equipo1);
            $equipos->push($partido->equipo2);
        }

        // Filtrar equipos únicos
        $equiposUnicos = $equipos->unique('id')->values();

        return response()->json($equiposUnicos);
    }

    public function partidos($id)
{
    $campeonato = Campeonato::findOrFail($id);
    $partidos = $campeonato->partidos;
    return response()->json($partidos);
}

}
