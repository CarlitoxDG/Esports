<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CampeonatosController;
use App\Http\Controllers\EquiposController;
use App\Http\Controllers\JuegosController;
use App\Http\Controllers\ParticipantesController;
use App\Http\Controllers\PartidosController;
use App\Http\Controllers\EquipoJuegoController;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::apiResource('/campeonatos',CampeonatosController::class);
Route::apiResource('/equipos',EquiposController::class);
Route::apiResource('/juegos',JuegosController::class);
Route::apiResource('/participantes',ParticipantesController::class);
Route::apiResource('/partidos',PartidosController::class);
Route::get('/equipos/{id}/participantes', [EquiposController::class, 'listarParticipantes']);
Route::get('/equipos/{equipo}/juegos', [EquiposController::class, 'juegosParticipantes']);
Route::get('campeonatos/{id}/equipos', [CampeonatosController::class, 'equiposEnCampeonato']);
Route::put('/participantes/{id}', [ParticipantesController::class, 'update']);
Route::post('/participantes', [ParticipantesController::class, 'store']);
Route::delete('/participantes/{id}', [ParticipantesController::class, 'destroy']);
Route::apiResource('/equipojuego', EquipoJuegoController::class);
Route::post('/equipojuego', [EquipoJuegoController::class, 'store']);
Route::delete('/juegos/{id}', [JuegosController::class, 'destroy']);
Route::get('/campeonatos/{id}/partidos', [CampeonatosController::class, 'partidos']);
Route::post('/partidos', [PartidosController::class, 'store']);
Route::post('/campeonatos',[CampeonatosController::class, 'store']);