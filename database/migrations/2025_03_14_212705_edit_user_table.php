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
     Schema::table('users' , function(Blueprint $table){
        $table->date('birthday')->nullable();
        $table->string('address')->nullable();
        $table->string('profilePicture')->nullable();
        $table->string('phone',15)->nullable()->unique();
     });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['birthday', 'profilePicture' ,'address' , 'phone']);
        });
    }
};
