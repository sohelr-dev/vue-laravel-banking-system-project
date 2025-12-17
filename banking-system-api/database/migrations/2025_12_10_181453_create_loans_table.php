<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('loans', function (Blueprint $table) {
            $table->id();
            $table->string('loan_no', 50)->unique();
            $table->unsignedBigInteger('customer_id');
            $table->string('product_code', 50)->nullable();
            $table->decimal('principal_amount', 18, 4);
            $table->decimal('outstanding_amount', 18, 4);
            $table->decimal('interest_rate', 8, 4)->default(0.0000);
            $table->integer('term_months')->default(0);
            $table->timestamp('disbursed_at')->nullable();
            $table->enum('status', ['applied','approved','disbursed','closed','defaulted','rejected'])->default('applied');
            $table->json('schedule')->nullable();
            $table->timestamps();
            $table->index('customer_id');
            
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('loans');
    }
};
