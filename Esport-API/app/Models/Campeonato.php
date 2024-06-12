<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Campeonato extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'campeonatos';

    public function partidos():HasMany
    {
        return $this->hasMany(Partido::class);
    }
}

