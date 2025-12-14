<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditLog;
use App\Models\Teller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:6|confirmed',

        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role_id' => 1,
        ]);

        if(!$user){
            return response()->Json([
                'success'=>false,
                'message'=>'Registration failed'
            ]);
        }
        return response()->json([
            'user' => $user,
            'massage'=>'Registration successfully',
            'success'=>true
         ],201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->select('role_id','id','email','password','name')->first();

        if ($user ){
            if(Hash::check($request->password, $user->password)){
                $token = $user->createToken('web-token')->plainTextToken;
                return response()->json([
                    'user' => $user,
                    'token' => $token,
                    'success'=>true
                ]);
            }else{
                return response()->json([
                    'error' => true,
                    'message' => 'Password does not match'
                ], 401);
            }
        }else{
            return response()->json([
                'error' => true,
                'message' => 'Email does not match'
            ], 401);
        }

    }

    public function logout()
    {
        auth()->user()->tokens()->delete();
        return response()->json([
            'success' => true,
            'message' => 'Logout successfully'
        ]);
    }

    /**
     * Store for teller registration.
     */
    public function storeTeller(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:150',
            'email' => 'required|email|unique:users,email',
            'phone' => 'nullable|string|max:30',
            'password' => 'required|min:6',
            'branch_id' => 'required|exists:branches,id',
            'daily_cash_limit' => 'nullable|numeric',
        ]);

        // create user
        $user =User::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => bcrypt($request->password),
            'role_id' => 2, // teller
        ]);

        // create teller
        $teller = Teller::create([
            'user_id' => $user->id,
            'branch_id' => $request->branch_id,
            'designation' => 'Cashier',
            'daily_cash_limit' => $request->daily_cash_limit ?? 0,
        ]);

        $auth = auth()->user();


        // optional audit log
        AuditLog::create([
            'user_id' => $auth->id,
            'action' => 'teller_created',
            'model' => 'User',
            'model_id' => $user->id,
        ]);

        return response()->json(['message' => 'Teller created successfully']);
    }
}
