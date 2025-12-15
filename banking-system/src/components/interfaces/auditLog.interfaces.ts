export interface AuditLogType {
  id: number;
  user_id?: number;
  action?: string;
  model?: string;
  model_id?: number;
  old_values?: Record<string, any>;
  new_values?: Record<string, any>;
  ip_address?: string;
  user_agent?: string;
  created_at?: string;
}

export const defaultAuditLog: AuditLogType = {
  id: 0,
  user_id: 0,
  action: '',
  model: '',
  model_id: 0,
  old_values: {},
  new_values: {},
  ip_address: '',
  user_agent: '',
  created_at: new Date().toISOString(),
};