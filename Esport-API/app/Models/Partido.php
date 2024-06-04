<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Partido extends Model
{
    use HasFactory;

    protected $table = 'partidos';

    public function torneo():BelongsTo
    {
        return $this->belongsTo(Torneo::class);
    }

    public function equipo1():BelongsTo
    {
        return $this->belongsTo(Equipo::class, 'equipo1_id');
    }

    public function equipo2():BelongsTo
    {
        return $this->belongsTo(Equipo::class, 'equipo2_id');
    }
}
