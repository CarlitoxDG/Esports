<?php

namespace App\Http\Controllers;

use App\Models\Juego;
use Illuminate\Http\Request;
use App\Http\Requests\JuegoRequest;

class JuegosController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Juego::all();
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
    public function store(JuegoRequest $request)
    {
        $juego = new Juego();
        $juego->nombre = $request->nombre;
        $juego->categoria = $request->categoria;
        $juego->save();
        return $juego;
    }

    /**
     * Display the specified resource.
     */
    public function show(Juego $juego)
    {
        return $juego;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Juego $juego)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(JuegoRequest $request,$id)
    {
        $juego = Juego::findOrFail($id);
        $juego->nombre = $request->nombre;
        $juego->categoria = $request->categoria;
        $juego->save();
        return $juego;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $juego = Juego::findOrFail($id);
        $juego->delete();
        return response()->json(['message' => 'Juego eliminado correctamente'], 200);
    }
}
