<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JuegosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('juegos')->insert([
            [
            'nombre' => 'Fortnite',
            'categoria' =>'Battle Royale',
            ],
            [
            'nombre' => 'League of Legends',
            'categoria' =>'Moba',
            ],
            [
            'nombre' => 'Valorant',
            'categoria' =>'Shooter 5vs5',
            ],
            [
            'nombre' => 'Teamfight Tactics',
            'categoria' =>'Estrategia',
            ],
            [
            'nombre' => 'Counter Strike: Global Offensive',
            'categoria' =>'Shooter 5vs5',
            ],
            [
            'nombre' => 'PUBG: BATTLEGROUNDS',
            'categoria' =>'Battle Royale',
            ],
        ]);
    }
}
