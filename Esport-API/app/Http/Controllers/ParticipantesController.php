<?php

namespace App\Http\Controllers;

use App\Models\Participante;
use Illuminate\Http\Request;
use App\Http\Requests\ParticipanteRequest;

class ParticipantesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Participante::all();
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
    public function store(ParticipanteRequest $request)
    {
        $participante = new Participante();
        $participante->nombre = $request->nombre;
        $participante->pais = $request->pais;
        $participante->equipo_id = $request->equipo_id;
        $participante->save();
        return $participante;
    }

    /**
     * Display the specified resource.
     */
    public function show(Participante $participante)
    {
        return $participante;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Participante $participante)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
   
     public function update(ParticipanteRequest $request, Participante $participante)
    {
        $participante->nombre = $request->nombre;
        $participante->pais = $request->pais;
        $participante->equipo_id = $request->equipo_id;
        $participante->save();
        return $participante;
    }  
/* 
    public function update(ParticipanteRequest $request, $id)
    {
        $participante = Participante::findOrFail($id);
        $participante->update($request->all());
        return response()->json($participante, 200);
    } */

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $participante = Participante::findOrFail($id);
        $participante->delete();
        return response()->json(['message' => 'Participante eliminado correctamente'], 200);
    }
}
