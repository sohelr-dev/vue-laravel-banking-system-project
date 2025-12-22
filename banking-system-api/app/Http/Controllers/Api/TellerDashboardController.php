<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Teller;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Str;

class TellerDashboardController extends Controller
{
    public function getSummary()
    {
        $user = Auth::user();
        $teller = DB::table('tellers as t')
            ->join('branches as b', 't.branch_id', '=', 'b.id')
            ->where('t.user_id', $user->id)
            ->select('t.*', 'b.name as branch_name')
            ->first();

        if (!$teller) {
            return response()->json([
                'success' => false,
                'message' => 'Teller record not found.'
            ], 404);
        }

        $today = Carbon::today();

        // deposit and withdrow summary
        $dailyStats = DB::table('transactions')
            ->where('teller_id', $teller->id)
            ->whereDate('created_at', $today)
            ->where('status', 'completed')
            ->selectRaw("
                SUM(CASE WHEN type = 'deposit' THEN amount ELSE 0 END) as total_deposit,
                COUNT(CASE WHEN type = 'deposit' THEN id END) as deposit_count,
                SUM(CASE WHEN type = 'withdrawal' THEN amount ELSE 0 END) as total_withdraw,
                COUNT(CASE WHEN type = 'withdrawal' THEN id END) as withdraw_count,
                COUNT(DISTINCT account_id) as customers_served
            ")
            ->first();

        // resent transactions
        $recentTransactions = DB::table('transactions as t')
            ->join('accounts as acc', 't.account_id', '=', 'acc.id')
            ->join('customers as c', 'acc.customer_id', '=', 'c.id')
            ->join('users as u', 'c.user_id', '=', 'u.id')
            ->where('t.teller_id', $teller->id)
            ->select(
                't.id',
                'u.name as customer_name',
                'acc.account_no',
                't.amount',
                't.type',
                't.status',
                't.created_at'
            )
            ->orderBy('t.created_at', 'desc')
            ->limit(5)
            ->get()
            ->map(function($item) {
                $item->time = Carbon::parse($item->created_at)->format('h:i A');
                $item->date = Carbon::parse($item->created_at)->format('d M, Y');
                return $item;
            });

        return response()->json([
            'success' => true,
            'stats' => [
                'branch_name'        => $teller->branch_name,
                'teller_code'        => $teller->teller_code,
                'daily_limit'        => (float) $teller->daily_cash_limit,
                'current_vault_cash' => (float) $teller->current_balance,
                'deposit' => [
                    'amount' => (float) ($dailyStats->total_deposit ?? 0),
                    'count'  => (int) ($dailyStats->deposit_count ?? 0)
                ],
                'withdraw' => [
                    'amount' => (float) ($dailyStats->total_withdraw ?? 0),
                    'count'  => (int) ($dailyStats->withdraw_count ?? 0)
                ],
                'customers_served' => (int) ($dailyStats->customers_served ?? 0)
            ],
            'recent_transactions' => $recentTransactions
        ]);
    }
    public function cashReturn(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1'
        ]);

        $user = Auth::user();
        $teller = DB::table('tellers')->where('user_id', $user->id)->first();

        // check amount
        if ($teller->current_balance < $request->amount) {
            return response()->json(['message' => 'Insufficient balance in your drawer!'], 400);
        }

        return DB::transaction(function () use ($request, $teller, $user) {
            $balanceBefore = $teller->current_balance;
            $balanceAfter = $balanceBefore - $request->amount;

            // update balance
            DB::table('tellers')->where('id', $teller->id)->update([
                'current_balance' => $balanceAfter
            ]);

            // transactions
            DB::table('transactions')->insert([
                'tx_uuid' => (string) Str::uuid(),
                'teller_id' => $teller->id,
                'type' => 'cash_return',
                'amount' => $request->amount,
                'balance_before' => $balanceBefore,
                'balance_after' => $balanceAfter,
                'status' => 'completed',
                'reference' => 'Cash returned to vault at end of day',
                'created_at' => now()
            ]);

            return response()->json(['success' => true, 'message' => 'Cash returned to vault successfully!']);
        });
    }
}
