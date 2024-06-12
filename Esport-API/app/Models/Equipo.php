<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;


class Equipo extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'equipos';

    public function participantes(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Participante::class);
    }

    public function partidos1():HasMany
    {
        return $this->hasMany(Partido::class, 'equipo1_id');
    }

    public function partidos2():HasMany
    {
        return $this->hasMany(Partido::class, 'equipo2_id');
    }

    public function juegos():BelongsToMany
    {
        return $this->belongsToMany(Juego::class, 'equipos_juegos','juego_id','equipo_id');
    }

    public function juegosParticipantes()
    {
        return $this->juegos;
    }
}
