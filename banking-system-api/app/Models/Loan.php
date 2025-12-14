<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Loan extends Model
{
    use HasFactory;

    protected $table = 'loans';

    protected $fillable = [
        'loan_no',
        'customer_id',
        'product_code',
        'principal_amount',
        'outstanding_amount',
        'interest_rate',
        'term_months',
        'disbursed_at',
        'status',
        'schedule',
    ];

    protected $casts = [
        'principal_amount' => 'decimal:4',
        'outstanding_amount' => 'decimal:4',
        'interest_rate' => 'decimal:4',
        'disbursed_at' => 'datetime',
        'schedule' => 'array',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Loan → Customer
    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    // Loan → Payments
    public function payments()
    {
        return $this->hasMany(LoanPayment::class);
    }
}
