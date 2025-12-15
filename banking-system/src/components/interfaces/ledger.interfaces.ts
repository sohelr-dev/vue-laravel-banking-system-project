export interface LedgerType {
  id: number;
  transaction_id: number;
  ledger_code?: string;
  debit_account?: string;
  credit_account?: string;
  amount?: number;
  narration?: string;
  created_at?: string;
}

export const defaultLedger: LedgerType = {
  id: 0,
  transaction_id: 0,
  ledger_code: '',
  debit_account: '',
  credit_account: '',
  amount: 0,
  narration: '',
  created_at: new Date().toISOString(),
};
