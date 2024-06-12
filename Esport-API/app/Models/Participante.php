<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Participante extends Model
{
    use HasFactory;

    protected $table = 'participantes';
    protected $fillable = ['nombre', 'pais', 'equipo_id'];
    public $timestamps = false;

    public function equipo():BelongsTo
    {
        return $this->belongsTo(Equipo::class);
    }
    
}

