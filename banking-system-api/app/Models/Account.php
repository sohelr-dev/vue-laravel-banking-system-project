<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Account extends Model
{
    use HasFactory,Notifiable,HasApiTokens;

    protected $table = 'accounts';

    protected $fillable = [
        'account_no',
        'customer_id',
        'branch_id',
        'account_type_id',
        'currency',
        'balance',
        'available_balance',
        'status',
        'metadata',
    ];

    protected $casts = [
        'balance' => 'decimal:4',
        'available_balance' => 'decimal:4',
        'metadata' => 'array', // JSON decode automatically
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Account → Customer
    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    // Account → Branch
    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    // Account → AccountType
    public function accountType()
    {
        return $this->belongsTo(AccountType::class, 'account_type_id');
    }

    // Account → Transactions
    public function transactions()
    {
        return $this->hasMany(Transaction::class);
    }
}
