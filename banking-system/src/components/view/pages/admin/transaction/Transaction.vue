<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import api from '@/config/config';
import { Modal } from 'bootstrap';

const transactions = ref<any[]>([]);
const meta = ref<any>({}); 
const loading = ref(true);
const searchQuery = ref('');
const currentPage = ref(1);
const selectedTx = ref<any>(null);


const fetchTransactions = async (page = 1) => {
    loading.value = true;
    try {
        const res = await api.get(`transactions?page=${page}&search=${searchQuery.value}`);
        transactions.value = res.data.data.data;
        meta.value = res.data.data; 
    } catch (e) {
        console.error("Error loading transactions", e);
    } finally {
        loading.value = false;
    }
};


const showDetails = (tx: any) => {
    selectedTx.value = tx;
    const modalElement = document.getElementById('detailsModal');
    if (modalElement) {
        const modal = new Modal(modalElement);
        modal.show();
    }
};


watch(searchQuery, () => {
    currentPage.value = 1;
    fetchTransactions(1);
});


const isCredit = (type: any): boolean => {
    if (!type) return false;
    const lowerType = String(type).toLowerCase().trim();
    return ['deposit', 'interest', 'cash_load', 'transfer_in'].includes(lowerType) || lowerType.endsWith('_in');
};

const formatCurrency = (val: any) => parseFloat(val).toLocaleString('en-BD', { minimumFractionDigits: 2 });

onMounted(() => fetchTransactions());
onMounted(() => {
    document.title = "Transaction | Admin";

});
</script>

<template>
    <div class="container py-4">
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-4">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h4 class="fw-bold text-navy mb-1">All Transactions</h4>
                        <p class="text-muted small">Monitor and manage every transaction in the system</p>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i
                                    class="fas fa-search text-muted"></i></span>
                            <input v-model="searchQuery" type="text" class="form-control border-start-0 ps-0"
                                placeholder="Search by Account No...">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr class="text-muted small text-uppercase fw-bold">
                            <th class="ps-4">Date</th>
                            <th>Acc/Name</th>
                            <th>TX ID</th>
                            <th class="text-center">Type</th>
                            <th class="text-end">Amount</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="loading">
                            <td colspan="6" class="text-center py-5">
                                <div class="spinner-border spinner-border-sm text-primary"></div>
                            </td>
                        </tr>
                        <tr v-for="tx in transactions" :key="tx.id" v-else>
                            <td class="ps-4 small">
                                <div>{{ new Date(tx.created_at).toLocaleDateString() }}</div>
                                <div class="extra-small text-muted">{{ new Date(tx.created_at).toLocaleTimeString() }}
                                </div>
                            </td>
                            <td>
                                <div class="fw-bold small">{{ tx.account?.account_no }}</div>
                                <div class="extra-small text-muted">{{ tx.account?.customer?.user?.name }}</div>
                            </td>
                            <td><code class="extra-small text-primary">{{ tx.tx_uuid.substring(0, 8) }}</code></td>
                            <td class="text-center">
                                <span class="badge rounded-pill extra-small"
                                    :class="isCredit(tx.type) ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'">
                                    {{ tx.type.replace('_', ' ').toUpperCase() }}
                                </span>
                            </td>
                            <td class="text-end fw-bold" :class="isCredit(tx.type) ? 'text-success' : 'text-dark'">
                                {{ isCredit(tx.type) ? '+' : '-' }} ৳{{ formatCurrency(tx.amount) }}
                            </td>
                            <td class="text-center">
                                <button @click="showDetails(tx)"
                                    class="btn btn-sm btn-white border shadow-sm rounded-pill px-3">
                                    <i class="fas fa-eye me-1"></i> Details
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white py-3 border-0 d-flex justify-content-between align-items-center">
                <span class="small text-muted">Showing {{ meta.from }} to {{ meta.to }} of {{ meta.total }}
                    entries</span>
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item" :class="{ disabled: !meta.prev_page_url }">
                            <button class="page-link rounded-start-pill px-3"
                                @click="fetchTransactions(meta.current_page - 1)">Prev</button>
                        </li>
                        <li class="page-item active"><span class="page-link">{{ meta.current_page }}</span></li>
                        <li class="page-item" :class="{ disabled: !meta.next_page_url }">
                            <button class="page-link rounded-end-pill px-3"
                                @click="fetchTransactions(meta.current_page + 1)">Next</button>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <div class="modal fade" id="detailsModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 rounded-4 shadow">
                    <div class="modal-header border-0 pb-0">
                        <h5 class="modal-title fw-bold">Transaction Receipt</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4" v-if="selectedTx">
                        <div class="text-center mb-4">
                            <h2 class="fw-bold" :class="isCredit(selectedTx.type) ? 'text-success' : 'text-danger'">
                                {{ isCredit(selectedTx.type) ? '+' : '-' }} ৳{{ formatCurrency(selectedTx.amount) }}
                            </h2>
                            <span class="badge rounded-pill"
                                :class="isCredit(selectedTx.type) ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'">
                                {{ selectedTx.type.toUpperCase() }}
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-2"><span>Status</span><span
                                class="text-success fw-bold">Success</span></div>
                        <div class="d-flex justify-content-between mb-2"><span>Reference</span><span>{{
                                selectedTx.reference || 'N/A' }}</span></div>
                        <div class="d-flex justify-content-between mb-2"><span>TX UUID</span><small
                                class="text-muted">{{ selectedTx.tx_uuid }}</small></div>
                        <hr class="text-muted opacity-25">
                        <div class="d-flex justify-content-between mb-2"><span>Account No</span><span class="fw-bold">{{
                                selectedTx.account?.account_no }}</span></div>
                        <div class="d-flex justify-content-between"><span>Account Holder</span><span>{{
                            selectedTx.account?.customer?.user?.name }}</span></div>
                    </div>
                    <div class="modal-footer border-0 pt-0">
                        <button class="btn btn-light w-100 rounded-pill" data-bs-dismiss="modal">Close</button>
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

.extra-small {
    font-size: 0.7rem;
}

.bg-success-subtle {
    background-color: #e8f5e9;
}

.bg-danger-subtle {
    background-color: #ffebee;
}
.page-link {
    color: #1a237e;
    cursor: pointer;
}
.page-item.active .page-link {
    background-color: #1a237e;
    border-color: #1a237e;
}
</style>