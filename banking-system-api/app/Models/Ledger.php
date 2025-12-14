<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Ledger extends Model
{
    use HasFactory;

    protected $table = 'ledgers';

    protected $fillable = [
        'transaction_id',
        'ledger_code',
        'debit_account',
        'credit_account',
        'amount',
        'narration',
    ];

    protected $casts = [
        'amount' => 'decimal:4',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Ledger → Transaction
    public function transaction()
    {
        return $this->belongsTo(Transaction::class);
    }
}
