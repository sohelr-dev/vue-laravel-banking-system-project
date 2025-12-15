export interface TellerType {
  id: number;
  user_id: number;
  teller_code?: string;
  branch_id: number;
  designation?: string;
  daily_cash_limit?: number;
  status?: 'active' | 'suspended';
  created_at?: string;
  updated_at?: string;
}

export const defaultTeller: TellerType = {
  id: 0,
  user_id: 0,
  teller_code: '',
  branch_id: 0,
  designation: 'Cashier',
  daily_cash_limit: 0,
  status: 'active',
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
