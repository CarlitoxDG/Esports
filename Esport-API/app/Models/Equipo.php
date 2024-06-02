<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Equipo extends Model
{
    use HasFactory;

    protected $table = 'equipos';

    public function participantes():HasMany 
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

    public function juego(): BelongsTo
    {
        return $this->belongsTo(Juego::class);
    }
}
