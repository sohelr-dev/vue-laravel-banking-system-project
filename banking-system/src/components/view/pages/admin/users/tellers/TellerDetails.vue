<script setup lang="ts">
import { ref, onMounted } from 'vue';
import api from '@/config/config';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();
const tellerId = route.params.id;

const loading = ref(true);
const error = ref('');
const teller = ref<any>(null);

const statusBadge = (status: any) => {
    const s = String(status).toLowerCase();
    return s === 'active' || s === '1'
        ? 'badge bg-success-subtle text-success border border-success'
        : 'badge bg-danger-subtle text-danger border border-danger';
};

const formatCurrency = (amount: any) => {
    return new Intl.NumberFormat('en-BD', { style: 'currency', currency: 'BDT' }).format(amount || 0);
};

const fetchTeller = async () => {
    try {
        const res = await api.get(`tellers/teller/${tellerId}`);
        if (res.data.success) teller.value = res.data.teller;
        else error.value = res.data.message || 'Failed to fetch teller';
    } catch (e: any) {
        error.value = e.message || 'Server error';
    } finally {
        loading.value = false;
    }
};

onMounted(fetchTeller);
</script>

<template>
    <div class="container-fluid py-4 bg-light min-vh-100">
        <div class="d-flex justify-content-between align-items-center mb-4 container-lg">
            <div>
                <h3 class="fw-bold text-navy mb-0">
                    <i class="fas fa-user-shield me-2"></i>Teller Operations Profile
                </h3>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 small">
                        <li class="breadcrumb-item"><a href="#" @click.prevent="router.push('/tellers')">Tellers</a>
                        </li>
                        <li class="breadcrumb-item active">View Details</li>
                    </ol>
                </nav>
            </div>
            <button class="btn btn-white shadow-sm border" @click="router.back()">
                <i class="fas fa-arrow-left me-1"></i> Back
            </button>
        </div>

        <div v-if="loading" class="text-center py-5">
            <div class="spinner-grow text-primary" role="status"></div>
            <p class="mt-2 text-muted fw-semibold">Securing Data Connection...</p>
        </div>
        <div v-else-if="error" class="alert alert-danger container-lg shadow-sm border-start border-4 border-danger">
            <i class="fas fa-exclamation-triangle me-2"></i> {{ error }}
        </div>

        <div v-else class="container-lg">
            <div class="row g-4">

                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                        <div class="card-header bg-navy py-4 text-center">
                            <div class="avatar-large mx-auto shadow">
                                {{ teller.teller_name.charAt(0) }}
                            </div>
                            <h5 class="text-white mt-3 mb-1 fw-bold">{{ teller.teller_name }}</h5>
                            <p class="text-white-50 small mb-0">{{ teller.designation }}</p>
                        </div>
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="text-muted small fw-bold">OPERATIONAL STATUS</span>
                                <span :class="statusBadge(teller.status)" class="px-3 py-1">
                                    {{ teller.status.toUpperCase() }}
                                </span>
                            </div>

                            <div class="info-item mb-3">
                                <label class="text-muted d-block small">Teller ID</label>
                                <span class="fw-semibold"><i class="fas fa-id-card me-2 text-primary"></i>{{
                                    teller.teller_code }}</span>
                            </div>
                            <div class="info-item mb-3">
                                <label class="text-muted d-block small">Email Address</label>
                                <span class="fw-semibold"><i class="fas fa-envelope me-2 text-primary"></i>{{
                                    teller.email }}</span>
                            </div>
                            <div class="info-item mb-0">
                                <label class="text-muted d-block small">Contact Number</label>
                                <span class="fw-semibold"><i class="fas fa-phone-alt me-2 text-primary"></i>{{
                                    teller.phone }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm bg-primary text-white p-3 rounded-4">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <p class="mb-1 small opacity-75">Current Till Balance</p>
                                        <h4 class="fw-bold mb-0">{{ formatCurrency(teller.current_till_balance || 0) }}
                                        </h4>
                                    </div>
                                    <i class="fas fa-vault fa-2x opacity-25"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm bg-warning text-dark p-3 rounded-4">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <p class="mb-1 small opacity-75">Daily Cash Limit</p>
                                        <h4 class="fw-bold mb-0">{{ formatCurrency(teller.daily_cash_limit) }}</h4>
                                    </div>
                                    <i class="fas fa-chart-line fa-2x opacity-25"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white py-3">
                            <ul class="nav nav-pills card-header-pills">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#"><i class="fas fa-university me-2"></i>Branch &
                                        Security</a>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <h6 class="fw-bold text-navy border-bottom pb-2 mb-3">Branch Details</h6>
                                    <p class="mb-2"><strong>Branch:</strong> {{ teller.branch_name }}</p>
                                    <p class="mb-2"><strong>Code:</strong> <code
                                            class="text-primary">{{ teller.branch_code }}</code></p>
                                    <p class="mb-2"><strong>Location Phone:</strong> {{ teller.branch_phone }}</p>
                                    <p class="mb-0"><strong>Status:</strong> <span
                                            :class="statusBadge(teller.branch_status)">{{ teller.branch_status }}</span>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="fw-bold text-navy border-bottom pb-2 mb-3">System Meta</h6>
                                    <div class="p-3 bg-light rounded-3">
                                        <p class="mb-1 small text-muted">Personal Account Connection:</p>
                                        <p class="mb-2 fw-bold text-dark">{{ teller.user_meta?.account_no || 'N/A' }}
                                        </p>
                                        <p class="mb-1 small text-muted">Current Ledger Balance:</p>
                                        <p class="mb-0 fw-bold text-success">{{
                                            formatCurrency(teller.user_meta?.balance) }}</p>
                                    </div>
                                    <div v-if="teller.user_meta?.reason"
                                        class="mt-3 alert alert-warning p-2 small mb-0">
                                        <strong>Note:</strong> {{ teller.user_meta.reason }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.text-navy {
    color: #1a237e;
}

.bg-navy {
    background-color: #1a237e;
}

.avatar-large {
    width: 90px;
    height: 90px;
    background-color: white;
    color: #1a237e;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
    font-weight: bold;
    border-radius: 50%;
    border: 4px solid rgba(255, 255, 255, 0.2);
}

.card {
    transition: transform 0.2s;
}

.info-item label {
    letter-spacing: 0.5px;
    font-weight: 700;
    margin-bottom: 2px;
}

.breadcrumb-item a {
    color: #1a237e;
    text-decoration: none;
}
</style>