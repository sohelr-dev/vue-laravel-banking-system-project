<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Teller extends Model
{
    use HasFactory;

    protected $table = 'tellers';

    protected $fillable = [
        'user_id',
        'teller_code',
        'branch_id',
        'designation',
        'daily_cash_limit',
        'current_balance',
        'status',
    ];

    protected $casts = [
        'daily_cash_limit' => 'decimal:2',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Teller → User
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Teller → Branch
    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}

