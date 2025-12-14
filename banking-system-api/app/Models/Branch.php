<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Branch extends Model
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $table = 'branches';

    protected $fillable = [
        'branch_code',
        'name',
        'address',
        'manager_id',
        'phone',
        'status',
    ];

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    // Branch → Manager (User)
    public function manager()
    {
        return $this->belongsTo(User::class, 'manager_id');
    }

    // Branch → Tellers
    public function tellers()
    {
        return $this->hasMany(Teller::class);
    }

    // Branch → Accounts
    public function accounts()
    {
        return $this->hasMany(Account::class);
    }
}
