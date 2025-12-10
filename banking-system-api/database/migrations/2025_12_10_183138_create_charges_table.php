<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('charges', function (Blueprint $table) {
            $table->id();
            $table->string('charge_code', 50)->unique();
            $table->string('name', 100);
            $table->decimal('amount', 18, 4);
            $table->enum('type', ['fixed','percentage'])->default('fixed');
            $table->unsignedBigInteger('account_type_id')->nullable();
            $table->string('description', 255)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('charges');
    }
};
