<?php

namespace App\Http\Controllers\Api\Register;

use App\Http\Controllers\Controller;
use App\Models\Account;
use App\Models\Customer;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Pest\Support\Str;

class CustomerRegistrationController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:150',
            'email' => 'required|email|unique:users,email',
            'phone' => 'required|string|unique:users,phone',
            'password' => 'required|min:6',
            'branch_id' => 'required|exists:branches,id',
            'account_type_id' => 'required|exists:account_types,id',
            'address' => 'nullable|string',
            'dob' => 'nullable|date',
        ]);

        DB::beginTransaction();
        try {
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'password' => Hash::make($request->password),
                'kyc_status' => 'pending',
                'role_id' => 3,
            ]);
            $customer = Customer::create([
                'user_id' => $user->id,
                'customer_code' => 'CUST-' . strtoupper(Str::random(6)),
                'branch_id' => $request->branch_id,
                'dob' => $request->dob,
                'address' => $request->address,
                'status' => 'active',
            ]);
            $account = Account::create([
                'account_no' => 'ACC-' . date('Y') . mt_rand(100000, 999999),
                'customer_id' => $customer->id,
                'branch_id' => $request->branch_id,
                'account_type_id' => $request->account_type_id,
                'currency' => 'BDT',
                'balance' => 0,
                'available_balance' => 0,
                'status' => 'active',
            ]);
            DB::commit();
            return response()->json([
                'success' => true,
                'message' => 'Customer registered and account opened successfully!',
                'data' => [
                    'customer_code' => $customer->customer_code,
                    'account_no' => $account->account_no
                ]
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Registration failed: ' . $e->getMessage()
            ], 500);
        }
    }
}
