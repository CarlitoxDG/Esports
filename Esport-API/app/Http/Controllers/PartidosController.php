<?php

namespace App\Http\Controllers;

use App\Models\Partido;
use Illuminate\Http\Request;
use App\Http\Requests\PartidoRequest;

class PartidosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Partido::all();
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
    public function store(PartidoRequest $request)
    {
        $partido = new Partido();
        $partido->fecha = $request->fecha;
        $partido->pais = $request->pais;
        $partido->ciudad = $request->ciudad;
        $partido->sede = $request->sede;
        $partido->resultado = $request->resultado;
        $partido->campeonato_id = $request->campeonato;
        $partido->equipo1_id = $request->equipo1;
        $partido->equipo2_id = $request->equipo2;
        $partido->save();
        return $partido;
    }

    /**
     * Display the specified resource.
     */
    public function show(Partido $partido)
    {
        return $partido;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Partido $partido)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(PartidoRequest $request, Partido $partido)
    {
        $partido->fecha = $request->fecha;
        $partido->pais = $request->pais;
        $partido->ciudad = $request->ciudad;
        $partido->sede = $request->sede;
        $partido->resultado = $request->resultado;
        $partido->campeonato_id = $request->campeonato;
        $partido->equipo1_id = $request->equipo1;
        $partido->equipo2_id = $request->equipo2;
        $partido->save();
        return $partido;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Partido $partido)
    {
        return $partido->delete();
    }
}
