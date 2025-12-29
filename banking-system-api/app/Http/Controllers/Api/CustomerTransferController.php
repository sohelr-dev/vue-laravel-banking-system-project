<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use App\Models\Account;
use App\Models\Transaction;

class CustomerTransferController extends Controller
{
    public function verifyAccount($account_no)
    {
        $account = DB::table('accounts as a')
            ->join('customers as c', 'a.customer_id', '=', 'c.id')
            ->join('users as u', 'c.user_id', '=', 'u.id')
            ->where('a.account_no', $account_no)
            ->where('a.status', 'active')
            ->select('u.name as account_holder_name', 'a.account_no')
            ->first();

        if (!$account) {
            return response()->json([
                'success' => false,
                'message' => 'Account not found or inactive'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'account_holder_name' => $account->account_holder_name
        ]);
    }

    public function transfer(Request $request)
    {
        $request->validate([
            'from_account_id' => 'required|exists:accounts,id',
            'to_account_no'   => 'required|exists:accounts,account_no',
            'amount'          => 'required|numeric|min:10',
            'narration'       => 'nullable|string|max:100'
        ]);

        try {
            return DB::transaction(function () use ($request) {
                $fromAccount = Account::lockForUpdate()->find($request->from_account_id);
                $toAccount = Account::where('account_no', $request->to_account_no)->first();
                    //for check account
                if ($fromAccount->account_no === $toAccount->account_no) {
                    throw new \Exception('You cannot transfer money to the same account.');
                }
                // Check balannce
                if ($fromAccount->balance < $request->amount) {
                    throw new \Exception('Insufficient balance in your account.');
                }
                $relation_id = (string) Str::uuid();
                // $tx_uuid = (string) Str::uuid();
                $transferAmount = $request->amount;
                // debit
                $fromOldBalance = $fromAccount->balance;
                $fromAccount->decrement('balance', $transferAmount);
                // Credit
                $toOldBalance = $toAccount->balance;
                $toAccount->increment('balance', $transferAmount);

                // from transaction
                Transaction::create([
                    'tx_uuid'        => (string) Str::uuid(),
                    'account_relation_id' => $relation_id,
                    'account_id'     => $fromAccount->id,
                    'type'           => 'transfer_out',
                    'amount'         => $transferAmount,
                    'balance_before' => $fromOldBalance,
                    'balance_after'  => $fromAccount->balance,
                    'status'         => 'completed',
                    'reference'      => 'TRF to ' . $toAccount->account_no,
                    'narration'      => $request->narration ?? 'Fund Transfer'
                ]);

                // to transaction
                Transaction::create([
                    'tx_uuid'        => (string) Str::uuid(),
                    'account_relation_id' => $relation_id,
                    'account_id'     => $toAccount->id,
                    'type'           => 'transfer_in',
                    'amount'         => $transferAmount,
                    'balance_before' => $toOldBalance,
                    'balance_after'  => $toAccount->balance,
                    'status'         => 'completed',
                    'reference'      => 'TRF from ' . $fromAccount->account_no,
                    'narration'      => $request->narration ?? 'Fund Transfer'
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Transfer Successful!',
                    'tx_id'   => $relation_id
                ]);
            });
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 422);
        }
    }
}
