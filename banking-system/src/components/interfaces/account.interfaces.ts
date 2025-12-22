export interface Account {
  id: number;
  account_no?: string;
  customer_id: number;
  branch_id?: number;
  account_type_id: number;
  currency?: string;
  type_name?: string;
  balance?: number;
  available_balance?: number;
  status?: 'active' | 'blocked' | 'closed';
  metadata?: Record<string, any>;
  created_at?: string;
  updated_at?: string;
}

export const defaultAccount: Account = {
  id: 0,
  account_no: '',
  customer_id: 0,
  branch_id: 0,
  account_type_id: 0,
  currency: 'BDT',
  balance: 0,
  available_balance: 0,
  status: 'active',
  metadata: {},
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
