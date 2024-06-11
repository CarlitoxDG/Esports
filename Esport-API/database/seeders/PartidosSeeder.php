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
            //campeonato 1
            [
            'fecha' => '2024-06-02',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>1,
            'equipo1_id'=>3,
            'equipo2_id'=>5,
            ],
            [
            'fecha' => '2024-06-03',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>1,
            'equipo1_id'=>1,
            'equipo2_id'=>3,
            ],
            [
            'fecha' => '2024-06-04',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>1,
            'equipo1_id'=>5,
            'equipo2_id'=>1,
            ],
            [
            'fecha' => '2024-06-10',
            'pais'=>'Chile',
            'ciudad'=> 'Viña del Mar',
            'sede'=>'Quinta Vergara',
            'resultado'=>'',
            'campeonato_id'=>1,
            'equipo1_id'=>1,
            'equipo2_id'=>3,
            ],
            //campeonato 2
            [
            'fecha' => '2024-06-20',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>2,
            'equipo1_id'=>2,
            'equipo2_id'=>6,
            ],
            [
            'fecha' => '2024-06-22',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>2,
            'equipo1_id'=>3,
            'equipo2_id'=>1,
            ],
            [
            'fecha' => '2024-06-24',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>2,
            'equipo1_id'=>2,
            'equipo2_id'=>3,
            ],
            [
            'fecha' => '2024-06-26',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>2,
            'equipo1_id'=>1,
            'equipo2_id'=>6,
            ],
            [
            'fecha' => '2024-06-30',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>2,
            'equipo1_id'=>2,
            'equipo2_id'=>6,
            ],
            //campeonato 3
            [
            'fecha' => '2024-07-01',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>3,
            'equipo1_id'=>4,
            'equipo2_id'=>5,
            ],
            [
            'fecha' => '2024-07-10',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>3,
            'equipo1_id'=>6,
            'equipo2_id'=>4,
            ],
            [
            'fecha' => '2024-08-30',
            'pais'=>'Chile',
            'ciudad'=> 'Quilpue',
            'sede'=>'Usm viña del mar',
            'resultado'=>'',
            'campeonato_id'=>3,
            'equipo1_id'=>6,
            'equipo2_id'=>5,
            ],
        ]);
    }
}
