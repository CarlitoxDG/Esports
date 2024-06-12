<?php

namespace App\Http\Controllers;

use App\Models\EquipoJuego;
use Illuminate\Http\Request;

class EquipoJuegoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return EquipoJuego::all();
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
        $equipoJuego = new EquipoJuego();
        $equipoJuego->equipo_id = $request->equipo_id;
        $equipoJuego->juego_id=$request->juego_id;
        $equipoJuego->save();
        return $equipoJuego; 
    }

    /**
     * Display the specified resource.
     */
    public function show(EquipoJuego $equipoJuego)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(EquipoJuego $equipoJuego)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, EquipoJuego $equipoJuego)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(EquipoJuego $equipoJuego)
    {
        return $equipoJuego->delete();
    }
}
