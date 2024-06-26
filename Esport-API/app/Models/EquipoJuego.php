<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EquipoJuego extends Model
{

    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['equipo_id', 'juego_id'];
    protected $table = 'equipos_juegos';

}
