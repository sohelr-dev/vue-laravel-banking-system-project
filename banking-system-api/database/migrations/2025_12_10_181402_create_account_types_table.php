<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('account_types', function (Blueprint $table) {
            $table->id();
            $table->string('type_name', 50)->unique();
            $table->string('description', 255)->nullable();
            $table->decimal('interest_rate', 8, 4)->default(0.0000);
            $table->decimal('min_balance', 18, 4)->default(0.0000);
            $table->integer('withdrawal_limit')->nullable();
            $table->json('config')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('account_types');
    }
};
