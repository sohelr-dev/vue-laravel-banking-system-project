export interface TransactionType {
  id: number;
  tx_uuid?: string;
  account_id: number;
  related_account_id?: number;
  type?: 'deposit' | 'withdrawal' | 'transfer' | 'fee' | 'interest' | 'adjustment';
  amount?: number;
  balance_before?: number;
  balance_after?: number;
  status?: 'pending' | 'completed' | 'failed' | 'cancelled';
  narration?: string;
  meta?: Record<string, any>;
  created_at?: string;
  updated_at?: string;
}

export const defaultTransaction: TransactionType = {
  id: 0,
  tx_uuid: '',
  account_id: 0,
  related_account_id: 0,
  type: 'deposit',
  amount: 0,
  balance_before: 0,
  balance_after: 0,
  status: 'pending',
  narration: '',
  meta: {},
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
