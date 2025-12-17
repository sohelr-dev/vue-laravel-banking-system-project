<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Customer extends Model
{
    use HasFactory;

    protected $table = 'customers';

    protected $fillable = [
        'user_id',
        'customer_code',
        'kyc_data',
        'dob',
        'address',
        'status',
    ];

    protected $casts = [
        'kyc_data' => 'array',
        'dob' => 'date',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Customer → User
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    // Customer → Branch
    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    // Customer → Accounts
    public function accounts()
    {
        return $this->hasMany(Account::class);
    }

    // Customer → Loans
    public function loans()
    {
        return $this->hasMany(Loan::class);
    }

    // Customer → KYC Documents
    public function kycDocuments()
    {
        return $this->hasMany(KycDocument::class);
    }
}

