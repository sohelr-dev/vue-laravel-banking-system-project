<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class LoanPayment extends Model
{
    use HasFactory;

    protected $table = 'loan_payments';

    protected $fillable = [
        'loan_id',
        'due_date',
        'amount_due',
        'amount_paid',
        'paid_at',
        'status',
        'meta',
    ];

    protected $casts = [
        'amount_due' => 'decimal:4',
        'amount_paid' => 'decimal:4',
        'due_date' => 'date',
        'paid_at' => 'datetime',
        'meta' => 'array',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // LoanPayment → Loan
    public function loan()
    {
        return $this->belongsTo(Loan::class);
    }
}
