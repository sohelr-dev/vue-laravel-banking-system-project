<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import api from '@/config/config';
import type { Account } from '@/components/interfaces/account.interfaces';
import type { TransactionType } from '@/components/interfaces/transaction.interfaces';


const loading = ref(true);
const dashboardData = ref<any>(null);
const customerProfile = ref({
    name: '',
    branch: '',
    code: '',
    kyc_status: 0
});

const accounts = ref<Account[]>([]);
const transactions = ref<TransactionType[]>([]);
const summary = ref({
    total_balance: 0,
    total_loan_outstanding: 0
});

//currency
const formatCurrency = (val: any) => {
    return new Intl.NumberFormat('en-BD', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(val || 0);
};

//balance 
const totalBalance = computed(() => summary.value.total_balance);
const totalLoan = computed(() => summary.value.total_loan_outstanding);

const fetchDashboardData = async () => {
    try {
        loading.value = true;
        const response = await api.get('customer/dashboard');
        console.log(response.data);

        if (response.data.success) {
            const data = response.data.data;
            customerProfile.value = {
                name: data.profile.name,
                branch: data.profile.branch_name,
                code: data.profile.customer_code,
                kyc_status: data.profile.kyc_status
            };

            accounts.value = data.accounts;
            transactions.value = data.transactions;
            // console.log(transactions.value)
            summary.value = data.summary;
        }
    } catch (error) {
        console.error("Dashboard API Error:", error);
    } finally {
        loading.value = false;
    }
};

onMounted(() => {
    fetchDashboardData();
});
</script>
<template>
    <div v-if="loading" class="text-center py-5">
        <div class="spinner-border text-primary"></div>
        <p class="mt-2">Loading your dashboard...</p>
    </div>
    <div class="container mt-4" v-else>
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 h-100 card-gradient-blue text-white">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="mb-0 opacity-75">Total Available Balance</h6>
                                <i class="fas fa-wallet fa-lg opacity-50"></i>
                            </div>
                            <h2 class="fw-bold mb-2">৳ {{ formatCurrency(totalBalance) }}</h2>
                            <p class="small mb-0"><i class="fas fa-info-circle me-1"></i> Across {{ accounts.length }}
                                Accounts</p>
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
                            <p class="small mb-0">Monthly Due: ৳ {{ formatCurrency(0) }}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 h-100 bg-white border-start border-4 border-success">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="mb-0 text-muted">Primary Account</h6>
                                <span class="badge bg-success-subtle text-success">Active</span>
                            </div>
                            <h4 class="fw-bold text-navy mb-1">{{ accounts[0]?.account_no }}</h4>
                            <p class="small text-muted mb-0">Branch: {{ customerProfile?.branch }}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden h-100">
                        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                            <h6 class="mb-0 fw-bold text-navy"><i class="fas fa-exchange-alt me-2"></i>Recent
                                Transactions</h6>
                            <button class="btn btn-sm btn-outline-primary">View All</button>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-4">Date</th>
                                        <th>Reference</th>
                                        <th>Type</th>
                                        <th class="text-end pe-4">Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="tx in transactions" :key="tx.id">
                                        <td class="ps-4 small text-muted">{{ tx.date }}</td>
                                        <td>
                                            <!-- <div class="fw-bold small">{{ tx.ref }}</div> -->
                                            <div class="text-muted extra-small">{{ tx.acc }}</div>
                                        </td>
                                        <td>
                                            <span :class="tx.type === 'Credit' ? 'text-success' : 'text-danger'"
                                                class="fw-bold small">
                                                {{ tx.type }}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4 fw-bold"
                                            :class="tx.type === 'Credit' ? 'text-success' : 'text-dark'">
                                            {{ tx.type === 'Credit' ? '+' : '-' }} ৳{{ formatCurrency(tx.amount) }}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 mb-4">
                        <div class="card-body p-4">
                            <h6 class="fw-bold mb-3 text-navy">Quick Actions</h6>
                            <div class="grid-actions">
                                <button class="action-btn">
                                    <i class="fas fa-paper-plane text-primary"></i>
                                    <span>Transfer</span>
                                </button>
                                <button class="action-btn">
                                    <i class="fas fa-file-invoice-dollar text-success"></i>
                                    <span>Pay Bill</span>
                                </button>
                                <button class="action-btn">
                                    <i class="fas fa-mobile-alt text-info"></i>
                                    <span>Recharge</span>
                                </button>
                                <button class="action-btn">
                                    <i class="fas fa-ellipsis-h text-muted"></i>
                                    <span>More</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4 bg-navy text-white p-1">
                        <div class="card-body text-center p-4">
                            <div class="mb-3">
                                <i class="fas fa-shield-check fa-3x text-warning"></i>
                            </div>
                            <h6 class="fw-bold">KYC Verified</h6>
                            <p class="small opacity-75 mb-0">Your profile is fully verified for all banking operations.
                            </p>
                        </div>
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