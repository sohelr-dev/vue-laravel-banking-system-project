<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('accounts', function (Blueprint $table) {
            $table->id();
            $table->string('account_no', 34)->unique();
            $table->unsignedBigInteger('customer_id');
            $table->unsignedBigInteger('branch_id')->nullable();
            $table->unsignedBigInteger('account_type_id');
            $table->char('currency', 3)->default('BDT');
            $table->decimal('balance', 18, 4)->default(0.0000);
            $table->decimal('available_balance', 18, 4)->default(0.0000);
            $table->enum('status', ['active','blocked','closed'])->default('active');
            $table->json('metadata')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('accounts');
    }
};
