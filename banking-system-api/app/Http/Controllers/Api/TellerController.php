<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditLog;
use App\Models\Teller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TellerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $tellers = Teller::from('tellers as t')
            ->join('users as u', 't.user_id', '=', 'u.id')
            ->join('branches as b', 't.branch_id', '=', 'b.id')

            // Search
            ->when($request->search, function ($q) use ($request) {
                $q->where(function ($sub) use ($request) {
                    $sub->where('u.name', 'like', '%'.$request->search.'%')
                        ->orWhere('t.teller_code', 'like', '%'.$request->search.'%');
                });
            })

            // Filter by Branch
            ->when($request->branch_id, function ($q) use ($request) {
                $q->where('t.branch_id', $request->branch_id);
            })

            // Filter by Status
            ->when($request->status !== null, function ($q) use ($request) {
                $q->where('t.status', $request->status);
            })

            ->select(
                't.id as teller_id',
                't.teller_code',
                't.designation',
                't.daily_cash_limit',
                't.status',
                'u.name as teller_name',
                'b.name as branch_name'
            )
            ->orderBy('t.id', 'desc')
            ->paginate(5);

        return response()->json([
            'success' => true,
            'message' => 'Teller list fetched successfully',
            'tellers' => $tellers
        ]);
    }
    public function show(string $id)
    {
        $tellers = Teller::from('tellers as t')
            ->join('users as u', 't.user_id', '=', 'u.id')
            ->join('branches as b', 't.branch_id', '=', 'b.id')
            ->where('t.id',$id)
            ->select(
                't.id as teller_id',
                't.teller_code',
                't.designation',
                't.daily_cash_limit',
                't.status',
                't.created_at',
                't.updated_at',
                'u.email',
                'u.phone',
                DB::raw('coalesce(u.meta, "{}") as user_meta'),
                'u.name as teller_name',
                'b.name as branch_name',
                'b.branch_code',
                'b.phone as branch_phone',
                'b.status as branch_status',
            )->first();
            // dd($tellers);


            if(!$tellers){
                return response()->json([
                    'success'=>false,
                    'message'=>'Teller not found'
                ],404);
            }
            $tellers->user_meta = json_decode($tellers->user_meta, true) ?? [];
            return response()->json([
                'success'=>true,
                'message'=>'Teller details fetched successfully',
                'teller'=>$tellers
            ],200);
    }

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
            'role_id' => 2,
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
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $teller = Teller::find($id);
        if (!$teller) {
            return response()->json([
                'success' => false,
                'message' => 'Teller not found'
            ], 404);
        }
            return response()->json([
                'success' => true,
                'message' => 'Teller deleted successfully'
            ], 200);

    }
}
