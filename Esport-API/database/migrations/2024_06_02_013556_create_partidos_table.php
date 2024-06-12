<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('partidos', function (Blueprint $table) {
            $table->unsignedInteger('id')->autoIncrement();
            $table->date('fecha');
            $table->string('pais', 20);
            $table->string('ciudad', 25);
            $table->string('sede', 50);
            $table->string('resultado', 20)->nullable();
            $table->unsignedInteger('campeonato_id');
            $table->unsignedInteger('equipo1_id');
            $table->unsignedInteger('equipo2_id');


            $table->foreign('campeonato_id')->references('id')->on('campeonatos')->onDelete('cascade');
            $table->foreign('equipo1_id')->references('id')->on('equipos')->onDelete('cascade');
            $table->foreign('equipo2_id')->references('id')->on('equipos')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('partidos');
    }
};
