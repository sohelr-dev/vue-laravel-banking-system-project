export interface UserType {
  id: number
  name: string
  email: string
  role_id?: number
  role?: string
  phone?: string
  kyc_status: 'pending' | 'verified' | 'rejected'
  meta?: Record<string, any>
}

export const defaultUser: UserType = {
  id: 0,
  name: '',
  email: '',
  role_id: undefined,
  phone: '',
  kyc_status: 'pending',
  meta: {}
}