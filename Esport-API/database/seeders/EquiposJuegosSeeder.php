<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EquiposJuegosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('equipos_juegos')->insert([
            //KRÜ
            [
            'equipo_id' =>1,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>1,
            'juego_id'=>3,
            ],
            [
            'equipo_id' =>1,
            'juego_id'=>4,
            ],
            [
            'equipo_id' =>1,
            'juego_id'=>5,
            ],
            //Leviatan
            [
            'equipo_id' =>2,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>2,
            'juego_id'=>3,
            ],
            [
            'equipo_id' =>2,
            'juego_id'=>5,
            ],
            //KOI
            [
            'equipo_id' =>3,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>3,
            'juego_id'=>3,
            ],
            [
            'equipo_id' =>3,
            'juego_id'=>4,
            ],
            //All Knights
            [
            'equipo_id' =>4,
            'juego_id'=>1,
            ],
            [
            'equipo_id' =>4,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>4,
            'juego_id'=>6,
            ],
            //Infinity
            [
            'equipo_id' =>5,
            'juego_id'=>1,
            ],
            [
            'equipo_id' =>5,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>5,
            'juego_id'=>4,
            ],
            [
            'equipo_id' =>5,
            'juego_id'=>5,
            ],
            //Team Heretics
            [
            'equipo_id' =>6,
            'juego_id'=>1,
            ],
            [
            'equipo_id' =>6,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>6,
            'juego_id'=>3,
            ],
            [
            'equipo_id' =>6,
            'juego_id'=>6,
            ],
            
        ]);
    }
}
