<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import api from '@/config/config';

const route = useRoute();
const router = useRouter();
const customer = ref<any>(null);
const customerDoc = ref<any>(null);
const customerAcc = ref<any>(null);
const customerLoan = ref<any>(null);
const loading = ref(true);

const fetchCustomerDetails = async () => {
    const id = route.params.id;
    try {
        const res = await api.get(`customers/show/${id}`);
        console.log(res.data);
        customer.value = res.data.data.profile;
        customerDoc.value = res.data.data.documents;
        customerAcc.value = res.data.data.accounts;
        customerLoan.value = res.data.data.loans;
    } catch (e) {
        console.error("Error fetching customer", e);
    } finally {
        loading.value = false;
    }
};
// console.log(customer.name);

const formatNum = (val: string) => {
    return parseFloat(val).toLocaleString(undefined, { minimumFractionDigits: 2 });
};

onMounted(fetchCustomerDetails);

const calculateProgress = (principal: string, outstanding: string) => {
    const p = parseFloat(principal);
    const o = parseFloat(outstanding);
    if (p <= 0) return 0;
    const paidPercent = ((p - o) / p) * 100;
    return paidPercent.toFixed(2);
};
</script>

<template>
    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="mb-0 text-navy fw-bold">
                    <i class="fas fa-id-card me-2"></i>Customer View
                </h4>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="#" @click.prevent="router.push('/customers')">Customers</a>
                        </li>
                        <li class="breadcrumb-item active">{{ customer?.code }}</li>
                    </ol>
                </nav>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-outline-primary btn-sm">
                    <i class="fas fa-print me-1"></i> Print Profile
                </button>
                <button class="btn btn-primary btn-sm" @click="router.push(`/customers/edit/${customer?.id}`)">
                    <i class="fas fa-edit me-1"></i> Edit Customer
                </button>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-xl-4 col-lg-5">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-body text-center py-4">
                        <div class="avatar-circle mx-auto mb-3">
                            {{ customer?.name.charAt(0) }}
                        </div>
                        <h5 class="fw-bold mb-1">{{ customer?.name }}</h5>
                        <span class="badge" :class="customer?.status === 'active' ? 'bg-success' : 'bg-danger'">
                            {{ customer?.status.toUpperCase() }}
                        </span>
                        <hr>
                        <div class="text-start space-y-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Customer ID:</span>
                                <span class="fw-bold small">{{ customer?.code }}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Branch:</span>
                                <span class="fw-bold small">{{ customer?.branch }}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Email:</span>
                                <span class="fw-bold small">{{ customer?.email }}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted small">Phone:</span>
                                <span class="fw-bold small">{{ customer?.phone }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white fw-bold py-3">
                        <i class="fas fa-file-invoice me-2 text-primary"></i>KYC Documents
                    </div>
                    <div class="list-group list-group-flush">
                        <div v-for="doc in customerDoc" :key="doc.id"
                            class="list-group-item d-flex justify-content-between align-items-center py-3">
                            <div>
                                <p class="mb-0 fw-bold text-capitalize small">{{ doc.document_type }}</p>
                                <small :class="doc.status === 'verified' ? 'text-success' : 'text-warning'">
                                    <i class="fas"
                                        :class="doc.status === 'verified' ? 'fa-check-circle' : 'fa-clock'"></i> {{
                                    doc.status }}
                                </small>
                            </div>
                            <a :href="doc.file_path" target="_blank" class="btn btn-light btn-sm border">
                                <i class="fas fa-eye text-primary"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-8 col-lg-7">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                        <span class="fw-bold"><i class="fas fa-university me-2 text-primary"></i>Linked Accounts</span>
                        <button class="btn btn-link btn-sm text-decoration-none">+ Open Account</button>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-3">Account No</th>
                                    <th>Purpose</th>
                                    <th class="text-end">Balance</th>
                                    <th class="text-center">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="acc in customerAcc" :key="acc.id">
                                    <td class="ps-3">
                                        <div class="fw-bold text-navy">{{ acc.account_no }}</div>
                                        <small class="text-muted">{{ acc.currency }}</small>
                                    </td>
                                    <td><span class="badge bg-light text-dark border text-capitalize">{{
                                            acc.metadata.purpose }}</span></td>
                                    <td class="text-end fw-bold text-primary">৳ {{ formatNum(acc.balance) }}</td>
                                    <td class="text-center">
                                        <span :class="acc.status === 'active' ? 'text-success' : 'text-danger'">
                                            <i class="fas fa-circle fs-xs me-1"></i>{{ acc.status }}
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white fw-bold py-3">
                        <i class="fas fa-hand-holding-usd me-2 text-primary"></i>Active Loans
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div v-for="loan in customerLoan" :key="loan.id" class="col-md-6">
                                <div class="p-3 border rounded bg-light-blue">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span class="fw-bold text-navy">{{ loan.loan_no }}</span>
                                        <span class="badge bg-primary">{{ loan.status }}</span>
                                    </div>
                                    <div class="small mb-1">Outstanding Amount:</div>
                                    <h5 class="fw-bold mb-3 text-danger">৳ {{ formatNum(loan.outstanding_amount) }}</h5>

                                    <div class="progress mb-2" style="height: 6px;">
                                        <div class="progress-bar" role="progressbar"
                                            :style="{ width: calculateProgress(loan.principal_amount, loan.outstanding_amount) + '%' }"
                                            :aria-valuenow="calculateProgress(loan.principal_amount, loan.outstanding_amount)"
                                            aria-valuemin="0" aria-valuemax="100">
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-between small text-muted">
                                        <span>Paid: {{ calculateProgress(loan.principal_amount, loan.outstanding_amount)
                                            }}%</span>
                                        <span>Remaining: ৳ {{ formatNum(loan.outstanding_amount) }}</span>
                                    </div>
                                    <small class="text-muted">Interest Rate: {{ loan.interest_rate }}% | Months: {{
                                        loan.term_months }}</small>
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

.bg-light-blue {
    background-color: #f0f4f8;
}

.avatar-circle {
    width: 80px;
    height: 80px;
    background-color: #1a237e;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    font-weight: bold;
}

.card {
    border-radius: 10px;
}

.fs-xs {
    font-size: 0.6rem;
}

.breadcrumb-item a {
    text-decoration: none;
    color: #1a237e;
}

.table thead th {
    font-size: 0.8rem;
    text-transform: uppercase;
    color: #666;
}
</style>