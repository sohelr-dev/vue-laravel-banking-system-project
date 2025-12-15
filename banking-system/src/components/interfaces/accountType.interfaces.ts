export interface AccountType{
  id: number;
  type_name?: string;
  description?: string;
  interest_rate?: number;
  min_balance?: number;
  withdrawal_limit?: number;
  config?: Record<string, any>;
  created_at?: string;
  updated_at?: string;
}

export const defaultAccountType: AccountType = {
  id: 0,
  type_name: '',
  description: '',
  interest_rate: 0,
  min_balance: 0,
  withdrawal_limit: 0,
  config: {},
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
