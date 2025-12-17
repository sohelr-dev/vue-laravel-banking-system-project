<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('interest_rules', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('account_type_id');
            $table->decimal('rate', 8, 4);
            $table->enum('calculation_method', ['daily','monthly','yearly'])->default('monthly');
            $table->enum('compounding', ['yes','no'])->default('no');
            $table->date('effective_from');
            $table->date('effective_to')->nullable();
            $table->timestamps();
            $table->index('account_type_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('interest_rules');
    }
};
