export interface ChargeType {
  id: number;
  charge_code?: string;
  name?: string;
  amount?: number;
  type?: 'fixed' | 'percentage';
  account_type_id?: number;
  description?: string;
  created_at?: string;
  updated_at?: string;
}

export const defaultCharge: ChargeType = {
  id: 0,
  charge_code: '',
  name: '',
  amount: 0,
  type: 'fixed',
  account_type_id: 0,
  description: '',
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
