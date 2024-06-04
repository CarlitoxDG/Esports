<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CampeonatosController;
use App\Http\Controllers\EquiposController;
use App\Http\Controllers\JuegosController;
use App\Http\Controllers\ParticipantesController;
use App\Http\Controllers\PartidosController;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::apiResource('/campeonatos',CampeonatosController::class);
Route::apiResource('/equipos',EquiposController::class);
Route::apiResource('/juegos',JuegosController::class);
Route::apiResource('/participantes',ParticipantesController::class);
Route::apiResource('/partidos',PartidosController::class);