<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tellers', function (Blueprint $table) {
            $table->id();

            $table->unsignedBigInteger('user_id');
            $table->string('teller_code', 30)->unique()->nullable();
            $table->unsignedBigInteger('branch_id');
            $table->string('designation', 50)->default('Cashier');
            $table->decimal('daily_cash_limit', 18, 4)->default(0);
            $table->decimal('current_balance', 15, 2)->default(0);
            $table->enum('status', ['active', 'suspended'])->default('active');
            $table->decimal('current_till_balance', 18, 4)->default(0.0000);

            $table->timestamps();

            $table->index('user_id');
            $table->index('branch_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tellers');
    }
};
