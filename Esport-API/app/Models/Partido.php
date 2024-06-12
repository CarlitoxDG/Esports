<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Partido extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'partidos';
    protected $fillable = ['fecha', 'pais', 'ciudad', 'sede', 'resultado', 'campeonato_id', 'equipo1_id', 'equipo2_id'];
    public $timestamps = false;
    public function campeonato():BelongsTo
    {
        return $this->belongsTo(Campeonato::class);
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
