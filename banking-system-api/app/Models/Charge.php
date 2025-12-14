<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Charge extends Model
{
    use HasFactory;

    protected $table = 'charges';

    protected $fillable = [
        'charge_code',
        'name',
        'amount',
        'type',
        'account_type_id',
        'description',
    ];

    protected $casts = [
        'amount' => 'decimal:4',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Charge → AccountType
    public function accountType()
    {
        return $this->belongsTo(AccountType::class, 'account_type_id');
    }
}
