<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transaction extends Model
{
    use HasFactory;

    protected $table = 'transactions';

    protected $fillable = [
        'tx_uuid',
        'account_id',
        'related_account_id',
        'type',
        'amount',
        'balance_before',
        'balance_after',
        'status',
        'narration',
        'meta',
    ];

    protected $casts = [
        'amount' => 'decimal:4',
        'balance_before' => 'decimal:4',
        'balance_after' => 'decimal:4',
        'meta' => 'array',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Transaction → Account
    public function account()
    {
        return $this->belongsTo(Account::class);
    }

    // Transaction → Related Account (for transfers)
    public function relatedAccount()
    {
        return $this->belongsTo(Account::class, 'related_account_id');
    }

    // Transaction → Ledger entries
    public function ledgers()
    {
        return $this->hasMany(Ledger::class);
    }
}
