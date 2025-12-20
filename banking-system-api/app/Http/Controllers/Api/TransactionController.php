<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Account;
use App\Models\Teller;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class TransactionController extends Controller
{
    public function searchAccount(Request $request)
    {
        $accountNo = $request->query('account_no');

        $account = Account::join('customers', 'accounts.customer_id', '=', 'customers.id')
            ->join('users', 'customers.user_id', '=', 'users.id')
            ->join('branches', 'accounts.branch_id', '=', 'branches.id')
            ->where('accounts.account_no', $accountNo)
            ->select(
                'accounts.*',
                'users.name as user_name',
                'branches.name as branch_name'
            )
            ->first();

        if (!$account) {
            return response()->json([
                'success' => false,
                'message' => 'Account not found!'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'account' => $account
        ]);
    }

    public function deposit(Request $request)
    {
        $request->validate([
            'id' => 'required|exists:accounts,id',
            'amount'     => 'required|numeric|min:1',
            'narration'  => 'nullable|string|max:255'
        ]);

        $user = Auth::user();
        $teller =Teller::where('user_id', $user->id)->first();

        if (!$teller) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized teller record.'
            ], 403);
        }

        try {
            return DB::transaction(function () use ($request, $teller, $user) {

                $account = Account::lockForUpdate()->findOrFail($request->id);

                $balanceBefore = $account->balance;
                $balanceAfter  = $balanceBefore + $request->amount;
                $account->update(['balance' => $balanceAfter]);

                $transaction = Transaction::create([
                    'tx_uuid'        => (string) Str::uuid(),
                    'account_id'     => $account->id,
                    'type'           => 'deposit',
                    'amount'         => $request->amount,
                    'balance_before' => $balanceBefore,
                    'balance_after'  => $balanceAfter,
                    'status'         => 'completed',
                    'teller_id'      => $teller->id,
                    'branch_id'      => $teller->branch_id,
                    'narration'      => $request->narration ?? 'Cash deposit by teller',
                    'meta' => [
                        'processed_by'  => $user->name,
                        'teller_user_id'=> $user->id,
                        'terminal_id'   => 'T-01',
                        'ip_address'     => $request->ip(),
                        'device'        => $request->header('User-Agent'),
                        'timestamp'     => now()->toDateTimeString(),
                    ]
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Deposit successful!',
                    'tx_uuid' => $transaction->tx_uuid,
                    'new_balance' => $balanceAfter
                ]);
            });

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Transaction failed: ' . $e->getMessage()
            ], 500);
        }
    }

    public function withdraw(Request $request)
    {
        $request->validate([
            'id'        => 'required|exists:accounts,id',
            'amount'    => 'required|numeric|min:1',
            'narration' => 'nullable|string|max:255'
        ]);
        $user = Auth::user();

        $teller = Teller::where('user_id', $user->id)->first();

        if (!$teller) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized: You are not a registered teller.'
            ], 403);
        }

        try {
            return DB::transaction(function () use ($request, $teller, $user) {
                $account = Account::lockForUpdate()->findOrFail($request->id);
                if ($account->balance < $request->amount) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Insufficient balance! Current balance: ' . $account->balance
                    ], 400);
                }

                $balanceBefore = $account->balance;
                $balanceAfter  = $balanceBefore - $request->amount;
                $account->update(['balance' => $balanceAfter]);

                $transaction = Transaction::create([
                    'tx_uuid'        => (string) Str::uuid(),
                    'account_id'     => $account->id,
                    'type'           => 'withdrawal',
                    'amount'         => $request->amount,
                    'balance_before' => $balanceBefore,
                    'balance_after'  => $balanceAfter,
                    'status'         => 'completed',
                    'teller_id'      => $teller->id,
                    'branch_id'      => $teller->branch_id,
                    'narration'      => $request->narration ?? 'Cash withdrawal by teller',
                    'meta' => [
                        'processed_by'   => $user->name,
                        'teller_user_id' => $user->id,
                        'terminal_id'    => 'T-01',
                        'ip_address'     => $request->ip(),
                        'device'         => $request->header('User-Agent'),
                        'timestamp'      => now()->toDateTimeString(),
                    ]
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Withdrawal successful!',
                    'tx_uuid' => $transaction->tx_uuid,
                    'new_balance' => $balanceAfter
                ]);
            });

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Transaction failed: ' . $e->getMessage()
            ], 500);
        }
    }
}
