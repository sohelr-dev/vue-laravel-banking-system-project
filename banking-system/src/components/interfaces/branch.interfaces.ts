export interface BranchType {
  id: number;
  branch_code?: string;
  name?: string;
  address?: string;
  manager_id?: number;
  phone?: string;
  status?: 'active' | 'inactive';
  created_at?: string;
  updated_at?: string;
}

export const defaultBranch: BranchType = {
  id: 0,
  branch_code: '',
  name: '',
  address: '',
  manager_id: 0,
  phone: '',
  status: 'active',
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
