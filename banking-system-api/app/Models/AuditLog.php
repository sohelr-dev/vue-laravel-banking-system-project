<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class AuditLog extends Model
{
    use HasFactory;

    protected $table = 'audit_logs';

    protected $fillable = [
        'user_id', 'action', 'model', 'model_id', 
        'before_data', 'after_data', 'ip_address', 'user_agent'
    ];

    protected $casts = [
        'before_data' => 'array',
        'after_data' => 'array',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // AuditLog → User
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
