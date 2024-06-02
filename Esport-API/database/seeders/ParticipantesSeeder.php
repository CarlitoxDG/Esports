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
            [
            'nombre' => 'Carlos',
            'pais'=>'Chile',
            'equipo_id'=> 1,
            ],
            [
            'nombre' => 'Ariel',
            'pais'=>'Alemania',
            'equipo_id'=> 3,
            ],
            [
            'nombre' => 'Mathias',
            'pais'=>'Chile',
            'equipo_id'=> 2,
            ],
        ]);
    }
}
