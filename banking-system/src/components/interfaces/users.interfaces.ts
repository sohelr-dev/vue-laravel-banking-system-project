export interface UserType {
  id: number;
  name: string;
  email: string;
  role_id?: number;
  password?: string
  password_confirmation?: string;
  phone?: string;
  role?: string;
  kyc_status: 'pending' | 'verified' | 'rejected';
  meta?: Record<string, any>;
}

export const defaultUser: UserType = {
  id: 0,
  name: '',
  email: '',
  role_id: 0,
  password:'',
  password_confirmation:'',
  phone: '',
  kyc_status: 'pending',
  meta: {}
}