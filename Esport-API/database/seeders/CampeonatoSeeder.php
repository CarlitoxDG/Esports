<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CampeonatoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('campeonatos')->insert([
            [
            'nombre' => 'Campeonato Esports 2024',
            'fecha_inicio' => '2024-06-01',
            'fecha_fin' => '2024-06-10',
            'reglas' => 'Reglas del campeonato',
            'premios' => 'Premios del campeonato'
            ],
            [
            'nombre' => 'Maters Valorant',
            'fecha_inicio' => '2024-06-20',
            'fecha_fin' => '2024-06-30',
            'reglas' => 'Reglas del campeonato',
            'premios' => 'Premios del campeonato'
            ],
            [
            'nombre' => 'Fortnite World Cup',
            'fecha_inicio' => '2024-07-01',
            'fecha_fin' => '2024-08-30',
            'reglas' => 'Reglas del campeonato',
            'premios' => 'Premios del campeonato'
            ],
    ]);
    }
}
