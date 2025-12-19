<script setup lang="ts">
import { ref, onMounted } from 'vue'
import api from '@/config/config'

const stats = ref<any>({
    total_customers: 0,
    daily_deposits: 0,
    daily_withdrawals: 0,
    current_vault_cash: 0
})

const recentTransactions = ref<any[]>([])
const loading = ref(false)
const today = new Date().toLocaleDateString();

const fetchDashboardData = async () => {
    loading.value = true
    try {
        const res = await api.get('teller/dashboard-summary')
        stats.value = res.data.stats
        console.log(stats.value);
        recentTransactions.value = res.data.recent_transactions
    } catch (error) {
        console.error("Dashboard data load failed")
    } finally {
        loading.value = false
    }
}

onMounted(fetchDashboardData)
</script>

<template>
    <div class="teller-dashboard py-4 px-3 px-lg-5 bg-light min-vh-100">

        <div class="row mb-4">
            <div class="col">
                <h4 class="fw-bold mb-1">Welcome back, Teller! 👋</h4>
                <p class="text-muted small">Branch: <span class="text-primary fw-semibold">{{ stats?.branch_name ?? "N/A" }}</span> |
                    Date: {{ today }}</p>
            </div>
            <div class="col-auto">
                <div class="d-flex gap-2">
                    <button class="btn btn-white shadow-sm rounded-pill px-3">
                        <i class="fas fa-print me-2"></i>Day Report
                    </button>
                    <button class="btn btn-primary shadow-sm rounded-pill px-4">
                        <i class="fas fa-exchange-alt me-2"></i>New Transaction
                    </button>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-primary-subtle text-primary me-3">
                            <i class="fas fa-university"></i>
                        </div>
                        <span class="text-muted small fw-bold uppercase">Vault Cash</span>
                    </div>
                    <h3 class="fw-bold mb-0">{{ stats?.current_vault_cash ?? 0 }}</h3>
                    <div class="progress mt-3" style="height: 6px;">
                        <div class="progress-bar bg-primary" style="width: 70%"></div>
                    </div>
                    <small class="text-muted mt-2 d-block">70% of daily limit used</small>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-success-subtle text-success me-3">
                            <i class="fas fa-arrow-down"></i>
                        </div>
                        <span class="text-muted small fw-bold uppercase">Today's Deposit</span>
                    </div>
                    <h3 class="fw-bold mb-0">{{stats.deposit?.amount ?? 0.000 }}</h3>
                    <small class="text-success mt-2 d-block"><i class="fas fa-level-up-alt"></i> 12 transactions</small>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-danger-subtle text-danger me-3">
                            <i class="fas fa-arrow-up"></i>
                        </div>
                        <span class="text-muted small fw-bold uppercase">Today's Withdraw</span>
                    </div>
                    <h3 class="fw-bold mb-0">{{ stats.withdraw?.amount ?? 0 }}</h3>
                    <small class="text-danger mt-2 d-block"><i class="fas fa-level-down-alt"></i> 08
                        transactions</small>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-info-subtle text-info me-3">
                            <i class="fas fa-users"></i>
                        </div>
                        <span class="text-muted small fw-bold uppercase">Customers Served</span>
                    </div>
                    <h3 class="fw-bold mb-0">{{ stats?.customers_served ?? 0 }}</h3>
                    <small class="text-muted mt-2 d-block">Across all accounts</small>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-header bg-white border-bottom-0 pt-4 px-4">
                        <h5 class="fw-bold">Quick Customer Search</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="input-group input-group-lg shadow-sm rounded-3 overflow-hidden">
                            <span class="input-group-text bg-white border-end-0 text-muted"><i
                                    class="fas fa-search"></i></span>
                            <input type="text" class="form-control border-start-0 ps-0"
                                placeholder="Enter Account Number or Phone..." />
                            <button class="btn btn-dark px-4">Find Account</button>
                        </div>
                        <div class="mt-3 d-flex gap-2">
                            <span class="text-muted small">Recent searches:</span>
                            <a href="#" class="badge bg-light text-dark text-decoration-none">ACC-10293</a>
                            <a href="#" class="badge bg-light text-dark text-decoration-none">017XXXXXXXX</a>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="mb-0 fw-bold">My Recent Transactions</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-light-subtle">
                                    <tr>
                                        <th class="ps-4">Time</th>
                                        <th>Customer</th>
                                        <th>Type</th>
                                        <th>Amount</th>
                                        <th class="text-end pe-4">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="ps-4 text-muted small">10:45 AM</td>
                                        <td>
                                            <div class="fw-bold">Rahim Uddin</div>
                                            <small class="text-muted">1002938475</small>
                                        </td>
                                        <td><span class="badge bg-success-subtle text-success">Deposit</span></td>
                                        <td class="fw-bold">BDT 5,000</td>
                                        <td class="text-end pe-4 text-success"><i class="fas fa-check-circle"></i></td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 text-muted small">11:20 AM</td>
                                        <td>
                                            <div class="fw-bold">Karim Ali</div>
                                            <small class="text-muted">2003948576</small>
                                        </td>
                                        <td><span class="badge bg-danger-subtle text-danger">Withdraw</span></td>
                                        <td class="fw-bold">BDT 12,000</td>
                                        <td class="text-end pe-4 text-success"><i class="fas fa-check-circle"></i></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 bg-primary text-white mb-4">
                    <div class="card-body p-4 text-center">
                        <div class="mb-3 mt-2">
                            <i class="fas fa-lock fa-3x opacity-50"></i>
                        </div>
                        <h5 class="fw-bold">Cash Counter Status</h5>
                        <p class="small opacity-75">Your counter is currently active. Don't forget to close the session
                            at end of day.</p>
                        <button class="btn btn-light w-100 rounded-pill fw-bold text-primary">Close Counter
                            (EOD)</button>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <h6 class="fw-bold mb-3">Pending Verification</h6>
                        <div class="d-flex align-items-center mb-3">
                            <div class="avatar-sm bg-warning-subtle text-warning me-3">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="flex-grow-1">
                                <div class="small fw-bold">Large Withdrawal</div>
                                <div class="text-muted" style="font-size: 0.75rem;">Acc: 5540 - BDT 2,00,000</div>
                            </div>
                            <button class="btn btn-sm btn-outline-secondary">Check</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.icon-box {
    width: 42px;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    font-size: 1.2rem;
}

.avatar-sm {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.bg-light {
    background-color: #f0f2f5 !important;
}

.stat-card {
    transition: transform 0.2s;
    cursor: default;
}

.stat-card:hover {
    transform: translateY(-5px);
}

.table thead th {
    font-size: 0.75rem;
    color: #6c757d;
    font-weight: 700;
}

.btn-white {
    background: white;
    border: 1px solid #dee2e6;
}
</style>