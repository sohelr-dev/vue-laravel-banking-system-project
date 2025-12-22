<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import api from '@/config/config'
import Swal from 'sweetalert2'
import * as bootstrap from 'bootstrap'

const stats = ref<any>({
    branch_name: '',
    teller_code: '',
    daily_limit: 0,
    current_vault_cash: 0,
    deposit: { amount: 0, count: 0 },
    withdraw: { amount: 0, count: 0 },
    customers_served: 0
})

const recentTransactions = ref<any[]>([])
const loading = ref(false)
const today = new Date().toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
const limitPercentage = computed(() => {
    if (!stats.value.daily_limit || stats.value.daily_limit === 0) return 0;
    const perc = (stats.value.current_vault_cash / stats.value.daily_limit) * 100;
    return perc > 100 ? 100 : Math.round(perc);
});

onMounted(()=>{
    document.title= "Dashboard | Teller";
})

const fetchDashboardData = async () => {
    loading.value = true
    try {
        const res = await api.get('teller/summary')
        if (res.data.success) {
            stats.value = res.data.stats
            recentTransactions.value = res.data.recent_transactions
        }
    } catch (error) {
        console.error("Dashboard data load failed", error)
    } finally {
        loading.value = false
    }
}

const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-BD', { style: 'currency', currency: 'BDT' }).format(value);
}

// for close balance

const isClosing = ref(false)
const returnAmount = ref(0)

const handleCashReturn = async () => {
    if (returnAmount.value <= 0) {
        Swal.fire('Error', 'Please enter a valid amount', 'error');
        return;
    }

    if (returnAmount.value > stats.value.current_vault_cash) {
        Swal.fire('Error', 'You cannot return more than your current balance', 'error');
        return;
    }

    isClosing.value = true;
    try {
        const res = await api.post('teller/cash-return', {
            amount: returnAmount.value,
            narration: 'End of day cash return to vault'
        });

        if (res.data.success) {
            Swal.fire('Success', 'Cash returned to vault and counter closed!', 'success');
            returnAmount.value = 0;

            fetchDashboardData();
            const modalElement = document.getElementById('cashReturnModal');
            const modal = bootstrap.Modal.getInstance(modalElement);
            modal.hide();
        }
    } catch (error: any) {
        Swal.fire('Error', error.response?.data?.message || 'Something went wrong', 'error');
    } finally {
        isClosing.value = false;
    }
}

onMounted(fetchDashboardData)
</script>

<template>
    <div class="teller-dashboard py-4 px-3 px-lg-5 bg-light min-vh-100">
        <div class="row mb-4 align-items-center">
            <div class="col">
                <h4 class="fw-bold mb-1">Welcome back, Teller! 👋</h4>
                <p class="text-muted small">
                    Branch: <span class="text-primary fw-semibold">{{ stats.branch_name || "Loading..." }}</span> |
                    Teller Code: <span class="fw-bold">{{ stats.teller_code }}</span> |
                    Date: {{ today }}
                </p>
            </div>
            <div class="col-auto">
                <div class="d-flex gap-2">
                    <button @click="fetchDashboardData" class="btn btn-white shadow-sm rounded-pill px-3">
                        <i class="fas fa-sync-alt me-2" :class="{ 'fa-spin': loading }"></i>Refresh
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
                        <span class="text-muted small fw-bold text-uppercase">Vault Cash</span>
                    </div>
                    <h3 class="fw-bold mb-0">{{ formatCurrency(stats.current_vault_cash) }}</h3>
                    <div class="progress mt-3" style="height: 6px;">
                        <div class="progress-bar bg-primary" :style="{ width: limitPercentage + '%' }"></div>
                    </div>
                    <small class="text-muted mt-2 d-block">{{ limitPercentage }}% of daily limit used</small>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-success-subtle text-success me-3">
                            <i class="fas fa-arrow-down"></i>
                        </div>
                        <span class="text-muted small fw-bold text-uppercase">Today's Deposit</span>
                    </div>
                    <h3 class="fw-bold mb-0 text-success">{{ formatCurrency(stats.deposit.amount) }}</h3>
                    <small class="text-success mt-2 d-block">
                        <i class="fas fa-level-up-alt"></i> {{ stats.deposit.count }} transactions
                    </small>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-danger-subtle text-danger me-3">
                            <i class="fas fa-arrow-up"></i>
                        </div>
                        <span class="text-muted small fw-bold text-uppercase">Today's Withdraw</span>
                    </div>
                    <h3 class="fw-bold mb-0 text-danger">{{ formatCurrency(stats.withdraw.amount) }}</h3>
                    <small class="text-danger mt-2 d-block">
                        <i class="fas fa-level-down-alt"></i> {{ stats.withdraw.count }} transactions
                    </small>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card p-3 shadow-sm rounded-4 border-0 bg-white h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="icon-box bg-info-subtle text-info me-3">
                            <i class="fas fa-users"></i>
                        </div>
                        <span class="text-muted small fw-bold text-uppercase">Customers Served</span>
                    </div>
                    <h3 class="fw-bold mb-0">{{ stats.customers_served }}</h3>
                    <small class="text-muted mt-2 d-block">Across unique accounts</small>
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
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div
                        class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold">My Recent Transactions</h5>
                        <a href="#" class="text-primary small text-decoration-none">View All</a>
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
                                    <tr v-for="tx in recentTransactions" :key="tx.id">
                                        <td class="ps-4 text-muted small">
                                            {{ tx.time }}<br>
                                            <span style="font-size: 0.7rem;">{{ tx.date }}</span>
                                        </td>
                                        <td>
                                            <div class="fw-bold">{{ tx.customer_name }}</div>
                                            <small class="text-muted text-uppercase">{{ tx.account_no }}</small>
                                        </td>
                                        <td>
                                            <span class="badge rounded-pill text-uppercase"
                                                :class="tx.type === 'deposit' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'">
                                                {{ tx.type }}
                                            </span>
                                        </td>
                                        <td class="fw-bold">{{ formatCurrency(tx.amount) }}</td>
                                        <td class="text-end pe-4">
                                            <span v-if="tx.status === 'completed'" class="text-success">
                                                <i class="fas fa-check-circle"></i>
                                            </span>
                                            <span v-else class="text-warning">
                                                <i class="fas fa-clock"></i>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr v-if="recentTransactions.length === 0">
                                        <td colspan="5" class="text-center py-4 text-muted">No transactions found today.
                                        </td>
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
                            <i class="fas fa-cash-register fa-3x opacity-50"></i>
                        </div>
                        <h5 class="fw-bold">Cash Counter Status</h5>
                        <p class="small opacity-75">Your counter is currently active. Don't forget to return cash to
                            vault at end of day.</p>
                        <button class="btn btn-light w-100 rounded-pill fw-bold text-primary shadow-sm mt-2"
                            data-bs-toggle="modal" data-bs-target="#cashReturnModal">
                            Close Counter & Return Cash
                        </button>
                    </div>
                </div>
                    <!-- model for close -->
                <div class="modal fade" id="cashReturnModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow rounded-4">
                            <div class="modal-header border-0 pt-4 px-4">
                                <h5 class="fw-bold mb-0">End of Day Cash Return</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-4">
                                <div class="alert alert-info border-0 rounded-3 small">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Your current drawer balance is <strong>{{ formatCurrency(stats.current_vault_cash)
                                        }}</strong>.
                                    Please return all physical cash to the main vault.
                                </div>

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">Amount to Return</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light border-0">৳</span>
                                        <input v-model="returnAmount" type="number"
                                            class="form-control bg-light border-0" :max="stats.current_vault_cash"
                                            placeholder="0.00">
                                    </div>
                                </div>

                                <div class="d-flex gap-2 mt-4">
                                    <button @click="returnAmount = stats.current_vault_cash"
                                        class="btn btn-outline-primary btn-sm rounded-pill">
                                        Return Full Balance
                                    </button>
                                </div>
                            </div>
                            <div class="modal-footer border-0 pb-4 px-4">
                                <button type="button" class="btn btn-light rounded-pill px-4"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button @click="handleCashReturn" class="btn btn-primary rounded-pill px-4"
                                    :disabled="isClosing || returnAmount <= 0">
                                    <span v-if="isClosing" class="spinner-border spinner-border-sm me-2"></span>
                                    Confirm & Close Counter
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <h6 class="fw-bold mb-3">Daily Support Info</h6>
                        <div class="d-flex align-items-center mb-3">
                            <div class="avatar-sm bg-info-subtle text-info me-3">
                                <i class="fas fa-info-circle"></i>
                            </div>
                            <div class="flex-grow-1">
                                <div class="small fw-bold">Manual Help</div>
                                <div class="text-muted" style="font-size: 0.75rem;">Call Vault Manager for extra cash
                                    loading.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* আপনার স্টাইলগুলো এখানে থাকবে */
.icon-box {
    width: 42px;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    font-size: 1.2rem;
}

.stat-card {
    transition: all 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05) !important;
}

.avatar-sm {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.progress-bar {
    transition: width 1s ease-in-out;
}
</style>