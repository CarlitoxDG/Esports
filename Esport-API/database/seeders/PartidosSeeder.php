<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PartidosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('partidos')->insert([
            [
            'fecha' => '2024-06-02',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>1,
            'equipo1_id'=>1,
            'equipo2_id'=>3,
            ],
        ]);
    }
}
