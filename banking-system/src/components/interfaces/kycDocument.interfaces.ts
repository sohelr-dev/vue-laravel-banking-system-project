export interface KYCDocumentType {
  id: number;
  customer_id: number;
  document_type?: 'nid' | 'passport' | 'birth_certificate' | 'utility_bill' | 'photo' | 'signature';
  file_path?: string;
  verified_by?: number;
  verified_at?: string;
  status?: 'pending' | 'verified' | 'rejected';
  remarks?: string;
  created_at?: string;
  updated_at?: string;
}

export const defaultKYCDocument: KYCDocumentType = {
  id: 0,
  customer_id: 0,
  document_type: 'nid',
  file_path: '',
  verified_by: 0,
  verified_at: '',
  status: 'pending',
  remarks: '',
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
};
