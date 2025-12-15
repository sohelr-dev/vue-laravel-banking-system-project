export interface InterestRuleType {
  id: number;
  account_type_id: number;
  rate?: number;
  calculation_method?: 'daily' | 'monthly' | 'yearly';
  compounding?: 'yes' | 'no';
  effective_from?: string;
  effective_to?: string;
  created_at?: string;
  updated_at?: string;
}

export const defaultInterestRule: InterestRuleType = {
  id: 0,
  account_type_id: 0,
  rate: 0,
  calculation_method: 'monthly',
  compounding: 'no',
  effective_from: new Date().toISOString(),
  effective_to: '',
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
