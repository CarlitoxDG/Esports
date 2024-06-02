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
            [
            'equipo_id' =>1,
            'juego_id'=>1,
            ],
            [
            'equipo_id' =>1,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>1,
            'juego_id'=>3,
            ],
            [
            'equipo_id' =>2,
            'juego_id'=>1,
            ],
            [
            'equipo_id' =>2,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>2,
            'juego_id'=>3,
            ],
            [
            'equipo_id' =>3,
            'juego_id'=>1,
            ],
            [
            'equipo_id' =>3,
            'juego_id'=>2,
            ],
            [
            'equipo_id' =>3,
            'juego_id'=>3,
            ],
        ]);
    }
}
