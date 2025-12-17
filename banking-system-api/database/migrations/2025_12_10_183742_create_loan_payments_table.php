<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('loan_payments', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('loan_id');
            $table->date('due_date');
            $table->decimal('amount_due', 18, 4);
            $table->decimal('amount_paid', 18, 4)->default(0.0000);
            $table->timestamp('paid_at')->nullable();
            $table->enum('status', ['pending','paid','overdue'])->default('pending');
            $table->json('meta')->nullable();
            $table->timestamps();
            $table->index('loan_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('loan_payments');
    }
};
