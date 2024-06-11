<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class ParticipantesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('participantes')->insert([
            //KRÜ
            [
            'nombre' => 'CarlitoxDG',
            'pais'=>'Chile',
            'equipo_id'=> 1,
            ],
            [
            'nombre' => 'Aosstu',
            'pais'=>'Alemania',
            'equipo_id'=> 1,
            ],
            [
            'nombre' => 'Mathias',
            'pais'=>'Chile',
            'equipo_id'=> 1,
            ],
            //Leviatan
            [
            'nombre' => 'kiNgg',
            'pais'=>'Chile',
            'equipo_id'=> 2,
            ],
            [
            'nombre' => 'Mazino',
            'pais'=>'Chile',
            'equipo_id'=> 2,
            ],
            [
            'nombre' => 'C0M',
            'pais'=>'Estados Unidos',
            'equipo_id'=> 2,
            ],
            [
            'nombre' => 'nzr',
            'pais'=>'Argentina',
            'equipo_id'=> 2,
            ],
            [
            'nombre' => 'Tex',
            'pais'=>'Alemania',
            'equipo_id'=> 2,
            ],
            //KOI
            [
            'nombre' => 'JUST',
            'pais'=>'España',
            'equipo_id'=> 3,
            ],
            [
            'nombre' => 'Stadodo',
            'pais'=>'España',
            'equipo_id'=> 3,
            ],
            [
            'nombre' => 'AdamS',
            'pais'=>'Francia',
            'equipo_id'=> 3,
            ],
            [
            'nombre' => 'Dav1g',
            'pais'=>'España',
            'equipo_id'=> 3,
            ],
            [
            'nombre' => 'Mopoz',
            'pais'=>'España',
            'equipo_id'=> 3,
            ],
            //All Knights
            [
            'nombre' => 'Hidan',
            'pais'=>'Brasil',
            'equipo_id'=> 4,
            ],
            [
            'nombre' => 'Grell',
            'pais'=>'México',
            'equipo_id'=> 4,
            ],
            [
            'nombre' => 'Nobody',
            'pais'=>'Argentina',
            'equipo_id'=> 4,
            ],
            [
            'nombre' => 'Lac',
            'pais'=>'Argentina',
            'equipo_id'=> 4,
            ],
            [
            'nombre' => 'Gastruks',
            'pais'=>'Argentina',
            'equipo_id'=> 4,
            ],
            //Infinity
            [
            'nombre' => 'Lumiere',
            'pais'=>'Perú',
            'equipo_id'=> 5,
            ],
            [
            'nombre' => 'Faker',
            'pais'=>'Perú',
            'equipo_id'=> 5,
            ],
            [
            'nombre' => 'Vitaly',
            'pais'=>'Perú',
            'equipo_id'=> 5,
            ],
            [
            'nombre' => 'Michael',
            'pais'=>'Perú',
            'equipo_id'=> 5,
            ],
            [
            'nombre' => 'Gardick',
            'pais'=>'Perú',
            'equipo_id'=> 5,
            ],
            //Team Heretics
            [
            'nombre' => 'Lowel',
            'pais'=>'España',
            'equipo_id'=> 6,
            ],
            [
            'nombre' => 'Paura',
            'pais'=>'Turquia',
            'equipo_id'=> 6,
            ],
            [
            'nombre' => 'Nukkye',
            'pais'=>'Lithuania',
            'equipo_id'=> 6,
            ],
            [
            'nombre' => 'Niesow',
            'pais'=>'Alemania',
            'equipo_id'=> 6,
            ],
            [
            'nombre' => 'Avova',
            'pais'=>'Dinamarca',
            'equipo_id'=> 6,
            ],

        ]);
    }
}
