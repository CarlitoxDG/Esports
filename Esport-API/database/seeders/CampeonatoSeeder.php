<?php

namespace Database\Seeders;

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
                'reglas' => 'Regla 1. Está prohibido el uso de software o hardware no autorizado que proporcione ventajas injustas. Esto incluye aimbots, wallhacks y cualquier tipo de cheats o hacks. \\n
                             Regla 2. Los jugadores deben estar presentes y listos para jugar a la hora programada. Retrasos no justificados pueden resultar en la descalificación del equipo o jugador. \\n
                             Regla 3. Los jugadores deben usar las configuraciones estándar del juego para la competición. Cualquier cambio debe ser aprobado por los organizadores del torneo. \\n
                             Regla 4. Los resultados de cada partida deben ser revisados y aprobados por los árbitros. Cualquier disputa o protesta debe ser reportada inmediatamente después del partido para su revisión. \\n
                             Regla 5. Todos los jugadores deben comportarse de manera profesional y respetuosa durante toda la competición. Insultos, lenguaje ofensivo, y conductas antideportivas serán sancionados. \\n',
                'premios' => 'Primer lugar: $5000 \\n
                              Segundo lugar: $3000 \\n
                              Tercer lugar: $1500 \\n'
            ],
            [
                'nombre' => 'Maters Valorant',
                'fecha_inicio' => '2024-06-20',
                'fecha_fin' => '2024-06-30',
                'reglas' => 'Regla 1. Se utiliza la última versión del juego Valorant durante el torneo.. \\n
                             Regla 2. Los modos de juego permitidos son "Plantado" y "Eliminación". \\n
                             Regla 3. Varía según el torneo, pero generalmente se juega con sistema de eliminación simple o doble, o con grupos y fases finales. \\n
                             Regla 4. Se espera un comportamiento deportivo y respetuoso por parte de todos los participantes.. \\n
                             Regla 5. Se otorgan premios al equipo ganador y a los finalistas del torneo. \\n',
                'premios' => 'Primer lugar: $7000 \\n
                              Segundo lugar: $4000 \\n
                              Tercer lugar: $2000 \\n'
            ],
            [
                'nombre' => 'Fortnite World Cup',
                'fecha_inicio' => '2024-07-01',
                'fecha_fin' => '2024-08-30',
                'reglas' => 'Regla 1. Los jugadores deben tener al menos 13 años (o la edad mínima requerida en su país de residencia). \\n
                             Regla 2. Se requiere una cuenta de Fortnite con buen historial (sin sanciones por infringir las reglas del juego). \\n
                             Regla 3. Se pueden prohibir ciertas tácticas o estrategias que se consideren antideportivas. \\n
                             Regla 4. Los jueces tienen la última palabra en todas las decisiones relacionadas con el juego. \\n
                             Regla 5. Todos los jugadores deben comportarse de manera profesional y respetuosa durante toda la competición. \\n',
                'premios' => 'Primer lugar: $10000 \\n
                              Segundo lugar: $5000 \\n
                              Tercer lugar: $3000 \\n'
            ],
        ]);
    }
}
