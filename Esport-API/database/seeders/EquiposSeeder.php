<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EquiposSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('equipos')->insert([
            [
            'logo' =>'https://www.kruesports.gg/assets/img/teams/teams/July2022/wXk2hPFVHNav2r910xWY.png',
            'nombre' => 'KRÜ',
            ],
            [
            'logo' =>'https://owcdn.net/img/61b8888cc3860.png',
            'nombre' => 'Leviatan',
            ],
            [
            'logo' =>'https://patchwiki.biligame.com/images/lol/7/76/ez3yqtjinvkrj7shfl4cy07lak7ku9h.png',
            'nombre' => 'KOI',
            ],
        ]);
    }
}
