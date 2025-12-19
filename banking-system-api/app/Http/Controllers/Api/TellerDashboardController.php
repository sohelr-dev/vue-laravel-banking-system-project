<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class TellerDashboardController extends Controller
{
    public function getSummary()
    {
        /** @var \App\Models\User $user */
        $user = Auth::user();


        $teller = DB::table('tellers')
            ->where('user_id', $user->id)
            ->first();

        if (!$teller) {
            return response()->json([
                'success' => false,
                'message' => 'Teller record not found.'
            ], 404);
        }

        $today = Carbon::today();

        $dailyDeposit = DB::table('transactions')
            ->where('teller_id', $teller->id)
            ->where('type', 'deposit')
            ->whereDate('created_at', $today)
            ->where('status', 'completed')
            ->select(
                DB::raw('SUM(amount) as total_amount'),
                DB::raw('COUNT(id) as count')
            )->first();

        $dailyWithdraw = DB::table('transactions')
            ->where('teller_id', $teller->id)
            ->where('type', 'withdrawal')
            ->whereDate('created_at', $today)
            ->where('status', 'completed')
            ->select(
                DB::raw('SUM(amount) as total_amount'),
                DB::raw('COUNT(id) as count')
            )->first();

        $recentTransactions = DB::table('transactions as t')
            ->join('accounts as acc', 't.account_id', '=', 'acc.id')
            ->join('users as u', 'acc.customer_id', '=', 'u.id')
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
                return $item;
            });
            // dd($recentTransactions);

        return response()->json([
            'success' => true,
            'stats' => [
                'branch_name' => DB::table('branches')->where('id', $teller->branch_id)->value('name'),
                'daily_limit' => $teller->daily_cash_limit,
                'current_vault_cash' => ($dailyDeposit->total_amount ?? 0) - ($dailyWithdraw->total_amount ?? 0),
                'deposit' => [
                    'amount' => $dailyDeposit->total_amount ?? 0,
                    'count' => $dailyDeposit->count ?? 0
                ],
                'withdraw' => [
                    'amount' => $dailyWithdraw->total_amount ?? 0,
                    'count' => $dailyWithdraw->count ?? 0
                ],
                'customers_served' => DB::table('transactions')
                    ->where('teller_id', $teller->id)
                    ->whereDate('created_at', $today)
                    ->distinct('account_id')
                    ->count('account_id')
            ],
            'recent_transactions' => $recentTransactions
        ]);

    }
}
