<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOffersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('offers', function (Blueprint $table) {
            $table->id();

            $table->unsignedbigInteger('agence_id');
            $table->foreign('agence_id')->references('id')->on('agences');

            $table->string('type_vente');
            $table->foreign('type_vente')->references('name')->on('categories');
        //     $table->unsignedbigInteger('category_id');

        //    $table->foreign('category_id')->references('id')->on('categories');
            $table->string('address');
            $table->text('description');
            $table->double('price');
            $table->double('latitude')->nullable();
            $table->double('longitude')->nullable();
            $table->double('space');
            $table->integer('n_etage')->nullable();
            $table->integer('n_chambre')->nullable();
            $table->string('wilaya');
            $table->json('photo')->nullable();
           
            $table->string('type_offer');
            $table->json('condition_de_paiment')->nullable();
            $table->json('specification')->nullable();
            $table->json('papiers')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('offers');
    }
}
