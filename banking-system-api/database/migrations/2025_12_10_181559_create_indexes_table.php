<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('accounts', function (Blueprint $table) {
            $table->index('customer_id');
            $table->index('account_no');
        });

        Schema::table('transactions', function (Blueprint $table) {
            $table->index('account_id');
            $table->index('created_at');
        });

        Schema::table('loans', function (Blueprint $table) {
            $table->index('customer_id');
        });

        Schema::table('audit_logs', function (Blueprint $table) {
            $table->index('user_id');
            $table->index('created_at');
        });
    }

    public function down(): void
    {
        Schema::table('accounts', function (Blueprint $table) {
            $table->dropIndex(['customer_id']);
            $table->dropIndex(['account_no']);
        });

        Schema::table('transactions', function (Blueprint $table) {
            $table->dropIndex(['account_id']);
            $table->dropIndex(['created_at']);
        });

        Schema::table('loans', function (Blueprint $table) {
            $table->dropIndex(['customer_id']);
        });

        Schema::table('audit_logs', function (Blueprint $table) {
            $table->dropIndex(['user_id']);
            $table->dropIndex(['created_at']);
        });
    }
};
