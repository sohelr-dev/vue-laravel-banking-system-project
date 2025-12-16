<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditLog;
use App\Models\Teller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

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
        // $auth = auth()->user();
        // dd($auth->id);
        $request->validate([
            'name' => 'required|string|min:6|max:150',
            'email' => 'required|email|unique:users,email',
            'phone' => 'nullable|string|max:30',
            'password' => 'required|min:6',
            'branch_id' => 'required|exists:branches,id',
            'daily_cash_limit' => 'nullable|numeric|min:0',
        ]);
        DB::beginTransaction();
        try {
            //create user
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'password' => Hash::make($request->password),
                'role_id' => 2,
            ]);
            //create teller
            $teller = Teller::create([
                'user_id' => $user->id,
                'branch_id' => $request->branch_id,
                'teller_code' => 'TLR'.str_pad($user->id, 6, '0', STR_PAD_LEFT),
                'designation' => 'Cashier',
                'daily_cash_limit' => $request->daily_cash_limit ?? 0,
            ]);
            //audit log
            DB::table('audit_logs')->insert([
                'user_id' => $request->auth_id ?? null,
                'action' => 'teller_created',
                'model' => 'Teller',
                'model_id' => $teller->id,
                'before_data' => '{}',
                'after_data' => json_encode($teller->toArray()),
                'ip_address' => request()->ip(),
                'user_agent' => request()->userAgent(),
            ]);
            DB::commit();
            return response()->json([
                'message' => 'Teller created successfully',
                'data' => [
                    'teller_id' => $teller->id,
                    'user_id' => $user->id
                ]
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'message' => 'Failed to create teller',
                'error' => $e->getMessage()
            ], 500);
        }
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
        $teller->delete();
            return response()->json([
                'success' => true,
                'message' => 'Teller deleted successfully'
            ], 200);

    }
}
