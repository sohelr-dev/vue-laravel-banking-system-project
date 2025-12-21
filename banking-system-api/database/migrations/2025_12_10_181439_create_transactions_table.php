<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->char('tx_uuid', 36)->unique();
            $table->unsignedBigInteger('account_id')->nullable();
            $table->unsignedBigInteger('related_account_id')->nullable();
            $table->unsignedBigInteger('branch_id')->nullable();
            $table->unsignedBigInteger('teller_id')->nullable();
            $table->enum('type', ['deposit','withdrawal','transfer','fee','interest','adjustment']);
            $table->decimal('amount', 18, 4);
            $table->decimal('balance_before', 18, 4);
            $table->decimal('balance_after', 18, 4);
            $table->enum('status', ['pending','completed','failed','cancelled'])->default('pending');
            $table->unsignedBigInteger('teller_id')->nullable();
            $table->string('reference', 255)->nullable();
            $table->string('narration', 255)->nullable();
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->index('account_id');
            $table->index('related_account_id');
            $table->index('type');
            $table->index('status');
            $table->index('teller_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};
