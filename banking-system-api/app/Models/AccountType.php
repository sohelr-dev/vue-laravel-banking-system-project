<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class AccountType extends Model
{
    use HasFactory;

    protected $table = 'account_types';

    protected $fillable = [
        'type_name',
        'description',
        'interest_rate',
        'min_balance',
        'withdrawal_limit',
        'config',
    ];

    protected $casts = [
        'interest_rate' => 'decimal:4',
        'min_balance' => 'decimal:4',
        'config' => 'array', // JSON decode automatically
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // AccountType → Accounts
    public function accounts()
    {
        return $this->hasMany(Account::class, 'account_type_id');
    }

    // AccountType → Charges
    public function charges()
    {
        return $this->hasMany(Charge::class, 'account_type_id');
    }

    // AccountType → InterestRules
    public function interestRules()
    {
        return $this->hasMany(InterestRule::class, 'account_type_id');
    }
}
