<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{CampeonatosController,EquiposController,JuegosController,ParticipantesController,PartidosController};

Route::get('/user', function (Request $request) {
    return $request->user();
})->middlewgitare('auth:sanctum');

Route::apiResource('/campeonatos',CampeonatosController::class);
Route::apiResource('/equipos',EquiposController::class);
Route::apiResource('/juegos',JuegosController::class);
Route::apiResource('/participantes',ParticipantesController::class);
Route::apiResource('/partidos',PartidosController::class);