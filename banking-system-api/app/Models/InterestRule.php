<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class InterestRule extends Model
{
    use HasFactory;

    protected $table = 'interest_rules';

    protected $fillable = [
        'account_type_id',
        'rate',
        'calculation_method',
        'compounding',
        'effective_from',
        'effective_to',
    ];

    protected $casts = [
        'rate' => 'decimal:4',
        'effective_from' => 'date',
        'effective_to' => 'date',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // InterestRule → AccountType
    public function accountType()
    {
        return $this->belongsTo(AccountType::class, 'account_type_id');
    }
}
