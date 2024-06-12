<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Juego extends Model
{
    use HasFactory;
    protected $table = 'juegos';
    protected $fillable = ['nombre', 'categoria', 'juego_id'];
    public $timestamps = false;
    public function equipos():BelongsToMany
    {
        return $this->belongsToMany(Equipo::class);
    }
}
