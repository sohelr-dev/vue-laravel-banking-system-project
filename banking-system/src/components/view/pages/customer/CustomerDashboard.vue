<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import api from '@/config/config';
import type { Account } from '@/components/interfaces/account.interfaces';

const loading = ref(true);
const customerProfile = ref({
    name: '',
    branch: '',
    code: '',
    kyc_status: ''
});

const accounts = ref<Account[]>([]);
const transactions = ref<any[]>([]); 
const summary = ref({
    total_balance: 0,
    total_loan_outstanding: 0,
    total_accounts: 0
});

// Currency Formatter
const formatCurrency = (val: number) => {
    return new Intl.NumberFormat('en-BD', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(val || 0);
};


// Computed properties
const totalBalance = computed(() => summary.value.total_balance);
const totalLoan = computed(() => summary.value.total_loan_outstanding);

const fetchDashboardData = async () => {
    try {
        loading.value = true;
        const response = await api.get('customer/dashboard');

        if (response.data.success) {
            const data = response.data.data;
            customerProfile.value = {
                name: data.profile.name,
                branch: data.profile.branch_name,
                code: data.profile.customer_code,
                kyc_status: data.profile.kyc_status
            };
            console.log(customerProfile);

            accounts.value = data.accounts;
            transactions.value = data.transactions;
            summary.value = data.summary;
            console.log(data.transactions);
        }
    } catch (error) {
        console.error("Dashboard API Error:", error);
    } finally {
        loading.value = false;
    }
};
//credit type formmet
const isCredit = (type: any): boolean => {
    if (!type || typeof type !== 'string') return false;

    const lowerType = type.toLowerCase().trim();
    const creditTypes = [
        'deposit',
        'interest',
        'cash_load',
        'transfer_in'
    ];
    return creditTypes.includes(lowerType);
};

onMounted(() => {
    fetchDashboardData();
});
</script>

<template>
    <div v-if="loading" class="d-flex flex-column align-items-center justify-content-center py-5 min-vh-100 bg-light">
        <div class="spinner-border text-primary" role="status"></div>
        <p class="mt-3 text-muted fw-semibold">Loading your dashboard...</p>
    </div>

    <div class="container py-4 px-3 px-lg-5" v-else>
        <div class="row mb-4 align-items-end">
            <div class="col">
                <h3 class="fw-bold text-navy mb-1">Hello, {{ customerProfile.name }}!</h3>
                <p class="text-muted small mb-0">
                    Customer ID: <span class="fw-bold text-primary">{{ customerProfile.code }}</span> |
                    <span class="fw-semibold">{{ customerProfile.branch }} Branch</span>
                </p>
            </div>
            <div class="col-auto">
                <button @click="fetchDashboardData" class="btn btn-white shadow-sm rounded-pill px-3 border">
                    <i class="fas fa-sync-alt me-1"></i> Refresh
                </button>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 card-gradient-blue text-white">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="mb-0 opacity-75">Total Available Balance</h6>
                            <i class="fas fa-wallet fa-lg opacity-50"></i>
                        </div>
                        <h2 class="fw-bold mb-2">৳ {{ formatCurrency(totalBalance) }}</h2>
                        <p class="small mb-0 opacity-75">
                            <i class="fas fa-info-circle me-1"></i> Across {{ summary.total_accounts }} Accounts
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 card-gradient-orange text-white">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="mb-0 opacity-75">Outstanding Loans</h6>
                            <i class="fas fa-hand-holding-usd fa-lg opacity-50"></i>
                        </div>
                        <h2 class="fw-bold mb-2">৳ {{ formatCurrency(totalLoan) }}</h2>
                        <p class="small mb-0 opacity-75">Monthly Due: ৳ 0.00</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 h-100 bg-white border-start border-4 border-success">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0 text-muted small fw-bold">PRIMARY ACCOUNT</h6>
                            <span class="badge bg-success-subtle text-success rounded-pill">Active</span>
                        </div>
                        <h4 class="fw-bold text-navy mb-1">{{ accounts[0]?.account_no || 'N/A' }}</h4>
                        <p class="small text-muted mb-0">{{ accounts[0]?.type_name || 'Savings Account' }}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                    <div
                        class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-0 pt-4 px-4">
                        <h6 class="mb-0 fw-bold text-navy"><i class="fas fa-exchange-alt me-2 text-primary"></i>Recent
                            Transactions</h6>
                        <button class="btn btn-sm btn-light rounded-pill px-3">View All</button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light-subtle">
                                <tr class="extra-small text-muted">
                                    <th class="ps-4 py-3 border-0">DATE & TIME</th>
                                    <th class="border-0">DETAILS</th>
                                    <th class="border-0 text-center">TYPE</th>
                                    <th class="text-end pe-4 border-0">AMOUNT</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="tx in transactions" :key="tx.id">
                                    <td class="ps-4">
                                        <div class="small fw-bold">{{ tx.date }}</div>
                                        <div class="extra-small text-muted">{{ tx.time }}</div>
                                    </td>
                                    <td>
                                        <div class="small fw-bold text-navy">{{ tx.reference || 'Bank Transaction' }}
                                        </div>
                                        <div class="extra-small text-muted text-uppercase">{{ tx.account_no }}</div>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge rounded-pill extra-small"
                                            :class="isCredit(tx.type) ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'">
                                            {{ tx.type.replace('_', ' ').toUpperCase() }}
                                        </span>
                                    </td>

                                    <td class="text-end pe-4 fw-bold"
                                        :class="isCredit(tx.type) ? 'text-success' : 'text-dark'">
                                        {{ isCredit(tx.type) ? '+' : '-' }} ৳{{ formatCurrency(tx.amount) }}
                                    </td>
                                </tr>
                                <tr v-if="transactions.length === 0">
                                    <td colspan="4" class="text-center py-5 text-muted">No transactions found.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 mb-4 bg-white">
                    <div class="card-body p-4">
                        <h6 class="fw-bold mb-3 text-navy">Quick Actions</h6>
                        <div class="grid-actions">
                            <router-link to="/customer/transfer" class="action-btn text-decoration-none">
                                <i class="fas fa-paper-plane text-primary"></i>
                                <span>Transfer</span>
                            </router-link>
                            <button class="action-btn">
                                <i class="fas fa-file-invoice-dollar text-success"></i>
                                <span>Pay Bill</span>
                            </button>
                            <button class="action-btn">
                                <i class="fas fa-mobile-alt text-info"></i>
                                <span>Recharge</span>
                            </button>
                            <button class="action-btn">
                                <i class="fas fa-shield-alt text-warning"></i>
                                <span>Security</span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card border-0 shadow-sm rounded-4 bg-navy text-white text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-shield-check fa-3x text-warning"></i>
                    </div>
                    <h6 class="fw-bold">{{ customerProfile.kyc_status ==='verified' ? 'Identity Verified' :"Verify Identity" }}</h6>
                    <p class="extra-small opacity-75 mb-0">Your account is fully secured and verified for all limits.
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.bg-navy {
    background-color: #1a237e;
}

.text-navy {
    color: #1a237e;
}

.card-gradient-blue {
    background: linear-gradient(135deg, #1a237e 0%, #3949ab 100%);
}

.card-gradient-orange {
    background: linear-gradient(135deg, #f57c00 0%, #ff9800 100%);
}

.avatar-sm {
    width: 40px;
    height: 40px;
}

.extra-small {
    font-size: 0.75rem;
}

.grid-actions {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
}

.action-btn {
    background: #f8f9fa;
    border: 1px solid #eee;
    padding: 15px;
    border-radius: 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    transition: all 0.2s;
}

.action-btn:hover {
    background: #fff;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    transform: translateY(-2px);
}

.action-btn i {
    font-size: 1.5rem;
}

.action-btn span {
    font-size: 0.8rem;
    font-weight: 600;
    color: #444;
}

.rounded-4 {
    border-radius: 1rem !important;
}
</style>