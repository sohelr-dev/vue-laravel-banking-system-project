<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
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
        if(!$customers){
            return response()->json([
                'success' => false,
                'message' => 'No customers found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Customer list fetched successfully',
            'customers' => $customers
        ],200);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
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
        //
    }
}
