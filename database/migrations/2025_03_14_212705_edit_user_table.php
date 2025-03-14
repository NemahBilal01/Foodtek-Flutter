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
        $table->date('birthday')->nullable()->after('email');
        $table->string('address')->nullable()->after('birthday');
        $table->string('profilePicture')->nullable()->after('address');
        $table->string('phone',15)->nullable()->after('profilePicture');
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
