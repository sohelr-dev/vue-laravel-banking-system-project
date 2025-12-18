<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CustomerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $customers = DB::table('customers as c')
            ->join('users as u', 'c.user_id', '=', 'u.id')
            ->join('branches as b', 'c.branch_id', '=', 'b.id')
            ->leftJoin('accounts as a', 'c.id', '=', 'a.customer_id')

            ->select(
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
                'customers' => []
            ], 200);
        }

        return response()->json([
            'success' => true,
            'message' => 'Customer list fetched successfully',
            'customers' => $customers
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
}
