export interface LoanType {
  id: number;
  loan_no?: string;
  customer_id: number;
  product_code?: string;
  principal_amount?: number;
  outstanding_amount?: number;
  interest_rate?: number;
  term_months?: number;
  disbursed_at?: string;
  status?: 'applied' | 'approved' | 'disbursed' | 'closed' | 'defaulted' | 'rejected';
  schedule?: Record<string, any>;
  created_at?: string;
  updated_at?: string;
}

export const defaultLoan: LoanType = {
  id: 0,
  loan_no: '',
  customer_id: 0,
  product_code: '',
  principal_amount: 0,
  outstanding_amount: 0,
  interest_rate: 0,
  term_months: 0,
  disbursed_at: '',
  status: 'applied',
  schedule: {},
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};