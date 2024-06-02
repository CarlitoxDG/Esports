<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Participante extends Model
{
    use HasFactory;

    protected $table = 'participantes';

    public function equipo():BelongsTo
    {
        return $this->belongsTo(Equipo::class);
    }
    
}

