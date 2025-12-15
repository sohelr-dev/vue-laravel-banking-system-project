export interface CustomerType {
  id: number;
  user_id?: number;
  customer_code?: string;
  kyc_data?: Record<string, any>;
  dob?: string;
  address?: string;
  status?: 'active' | 'inactive' | 'closed';
  created_at?: string;
  updated_at?: string;
}

export const defaultCustomer: CustomerType = {
  id: 0,
  user_id: 0,
  customer_code: '',
  kyc_data: {},
  dob: new Date().toISOString(),
  address: '',
  status: 'active',
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
