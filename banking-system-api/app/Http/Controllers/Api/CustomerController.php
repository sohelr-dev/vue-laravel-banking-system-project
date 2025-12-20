<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CustomerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $user = Auth::user();
        // dd($user);
        $query = DB::table('customers as c')
            ->join('users as u', 'c.user_id', '=', 'u.id')
            ->join('branches as b', 'c.branch_id', '=', 'b.id')
            ->leftJoin('accounts as a', 'c.id', '=', 'a.customer_id');
            if ($user->role_id === 2) {
                $tellerBranchId = DB::table('tellers')->where('user_id', $user->id)->value('branch_id');
                $query->where('c.branch_id', $tellerBranchId);
                // dd($tellerBranchId);
            }

            $customers=$query->select(
                'c.id as customer_id',
                'c.customer_code',
                'u.name as customer_name',
                'u.phone',
                'b.name as branch_name',
                'c.status',
                DB::raw('COUNT(a.id) as accounts_count')
            )

            // Search (name / code / phone)
            ->when($request->search, function ($q) use ($request) {
                $q->where(function ($sub) use ($request) {
                    $sub->where('u.name', 'like', '%' . $request->search . '%')
                        ->orWhere('c.customer_code', 'like', '%' . $request->search . '%')
                        ->orWhere('u.phone', 'like', '%' . $request->search . '%');
                });
            })

            // Branch filter
            ->when($request->branch_id, function ($q) use ($request) {
                $q->where('c.branch_id', $request->branch_id);
            })

            //  Status filter
            ->when($request->status !== null, function ($q) use ($request) {
                $q->where('c.status', $request->status);
            })
            ->groupBy(
                'c.id',
                'c.customer_code',
                'u.name',
                'u.phone',
                'b.name',
                'c.status'
            )
            ->orderBy('c.id', 'desc')
            ->paginate(5);

            // dd($customers);
        if($customers->isEmpty()){
            return response()->json([
                'success' => false,
                'message' => 'No customers found',
                'customers' => [],
                'user'=>$user->id
            ], 200);
        }

        return response()->json([
            'success' => true,
            'message' => 'Customer list fetched successfully',
            'customers' => $customers,

        ],200);
    }
    /**
     * Display the specified resource.
     */
    public function show($id)
    {

        $customer = Customer::with(['user', 'branch', 'accounts', 'kycDocuments', 'loans'])
            ->find($id);

        if (!$customer) {
            return response()->json([
                'success' => false,
                'message' => 'Customer not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Customer details fetched successfully',
            'data' => [
                'profile' => [
                    'user_id' => $customer->user->id,
                    'name'    => $customer->user->name,
                    'email'   => $customer->user->email,
                    'phone'   => $customer->user->phone,
                    'code'    => $customer->customer_code,
                    'branch'  => $customer->branch->name,
                    'address' => $customer->address,
                    'dob'     => $customer->dob,
                    'status'  => $customer->status,
                    'id'      => $customer->id,
                ],
                'accounts'  => $customer->accounts,
                'documents' => $customer->kycDocuments,
                'loans'     => $customer->loans
            ]
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $customer = Customer::find($id);
        if (!$customer) {
            return response()->json([
                'success' => false,
                'message' => 'Customer not found'
            ], 404);
        }

        $customer->delete();

        return response()->json([
            'success' => true,
            'message' => 'Customer deleted successfully'
        ], 200);
    }

    //Customer Dashboard
    public function getDashboardData()
    {
        $user = Auth::user();
        $customer = DB::table('customers')
        ->join('branches as b','b.id', '=','customers.branch_id')
        ->where('user_id', $user->id)
        ->select('customers.*','b.name as branch_name')
            ->first();

        if (!$customer) {
            return response()->json([
                'success' => false,
                'message' => 'Customer profile not found'
            ], 404);
        }
        $accounts = DB::table('accounts as a')
            ->join('account_types as at', 'a.account_type_id', '=', 'at.id')
            ->where('a.customer_id', $customer->id)
            ->select('a.id', 'a.account_no', 'a.balance', 'a.status', 'at.type_name', 'a.currency')
            ->get();

        $totalBalance = $accounts->sum('balance');
        $loans = DB::table('loans')
            ->where('customer_id', $customer->id)
            ->select(
                DB::raw('SUM(principal_amount) as total_principal'),
                DB::raw('SUM(outstanding_amount) as total_outstanding'),
                DB::raw('COUNT(id) as active_loans')
            )
            ->first();
        $recentTransactions = DB::table('transactions as t')
            ->join('accounts as acc', 't.account_id', '=', 'acc.id')
            ->where('acc.customer_id', $customer->id)
            ->select(
                't.id',
                't.created_at as date',
                // 't.reference as ref',
                'acc.account_no as acc',
                't.type',
                't.amount'
            )
            ->orderBy('t.created_at', 'desc')
            ->limit(5)
            ->get();
        return response()->json([
            'success' => true,
            'data' => [
                'profile' => [
                    'name' => $user->name,
                    'customer_code' => $customer->customer_code,
                    'branch_name' => $customer->branch_name,
                    'kyc_status' => $user->kyc_status,
                ],
                'summary' => [
                    'total_balance' => $totalBalance,
                    'total_loan_outstanding' => $loans->total_outstanding ?? 0,
                    'total_accounts' => $accounts->count(),
                ],
                'accounts' => $accounts,
                'transactions' => $recentTransactions
            ]
        ], 200);
    }
}
