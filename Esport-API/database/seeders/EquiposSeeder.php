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
            'nombre' => 'KRÜ',
            ],
            [
            'nombre' => 'Leviatan',
            ],
            [
            'nombre' => 'KOI',
            ],
            [
            'nombre' => 'All Knights',
            ],
            [
            'nombre' => 'Infinity',
            ],
            [
            'nombre' => 'Team Heretics',
            ],
        ]);
    }
}
