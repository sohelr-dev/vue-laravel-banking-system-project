<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class KycDocument extends Model
{
    use HasFactory;

    protected $table = 'kyc_documents';

    protected $fillable = [
        'customer_id',
        'document_type',
        'file_path',
        'verified_by',
        'verified_at',
        'status',
        'remarks',
    ];

    protected $casts = [
        'verified_at' => 'datetime',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // KycDocument → Customer
    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    // KycDocument → Verified By User
    public function verifiedBy()
    {
        return $this->belongsTo(User::class, 'verified_by');
    }
}
