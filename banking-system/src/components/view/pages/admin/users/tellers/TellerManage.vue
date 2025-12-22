<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import api from '@/config/config'

interface TellerType {
    teller_id: number
    teller_code: string
    teller_name: string
    branch_name: string
    designation: string
    daily_cash_limit: number
    status: string // 'active' | 'suspended' | 'inactive'
}

const tellers = ref<TellerType[]>([])
const loading = ref(false)
const search = ref('')
const branch_id = ref('')
const status = ref('')
const page = ref(1)
const pagination = ref<any>(null)
const branches = ref<any[]>([]) 

// Fetch Branches 
const fetchBranches = async () => {
    try {
        const res = await api.get('/branches')
        branches.value = res.data.branches
    } catch (e) { console.error(e) }
}

const fetchTellers = () => {
    loading.value = true
    api.get('tellers', {
        params: {
            search: search.value,
            branch_id: branch_id.value,
            status: status.value,
            page: page.value,
        },
    })
        .then(res => {
            if (res.data.success) {
                tellers.value = res.data.tellers.data
                pagination.value = res.data.tellers
            }
        })
        .finally(() => (loading.value = false))
}

onMounted(() => {
    document.title="Teller Management"
    fetchBranches()
    fetchTellers()
})

watch([search, branch_id, status], () => {
    page.value = 1
    fetchTellers()
})

const changePage = (p: number) => {
    page.value = p
    fetchTellers()
}

const deleteTeller = (id: number) => {
    if (!confirm('Are you sure you want to delete this teller?')) return
    api.delete(`tellers/${id}`).then(res => {
        if (res.data.success) {
            tellers.value = tellers.value.filter(t => t.teller_id !== id)
        }
    })
}
</script>

<template>
    <div class="page-content py-4 px-3 px-lg-5 bg-light min-vh-100">

        <div class="row align-items-center mb-4">
            <div class="col">
                <h3 class="fw-bold text-dark-emphasis mb-1">
                    <i class="fas fa-user-shield me-2 text-primary"></i>Teller Management
                </h3>
                <p class="text-muted small mb-0">Manage system tellers, cash limits, and branch assignments.</p>
            </div>
            <div class="col-auto">
                <router-link to="/tellers/cash-load" class="btn btn-primary shadow-sm px-4 rounded-pill me-2">
                    <i class="fas fa-plus me-2"></i>Cash Add
                </router-link>
                <router-link to="/tellers/add" class="btn btn-primary shadow-sm px-4 rounded-pill">
                    <i class="fas fa-plus me-2"></i>Add New Teller
                </router-link>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-lg-5">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0 text-muted">
                                <i class="fas fa-search"></i>
                            </span>
                            <input v-model="search" type="text" class="form-control border-start-0 ps-0"
                                placeholder="Search by teller name or code..." />
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <select v-model="branch_id" class="form-select border-1">
                            <option value="">All Branches</option>
                            <option v-for="b in branches" :key="b.id" :value="b.id">{{ b.branch_name }}</option>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <select v-model="status" class="form-select border-1">
                            <option value="">All Status</option>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <button class="btn btn-dark w-100 rounded-3" @click="fetchTellers">
                            <i class="fas fa-filter me-2"></i>Filter
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 custom-table">
                    <thead>
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Teller Profile</th>
                            <th>Branch & Role</th>
                            <th>Daily Cash Limit</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-if="loading">
                            <td colspan="6" class="py-5 text-center">
                                <div class="spinner-border text-primary spinner-border-sm me-2" role="status"></div>
                                <span class="text-muted fw-medium">Loading records...</span>
                            </td>
                        </tr>

                        <tr v-for="teller in tellers" :key="teller.teller_id">
                            <td class="ps-4">
                                <span class="text-muted fw-bold">#{{ teller.teller_id }}</span>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="avatar-box me-3">
                                        {{ teller.teller_name?.charAt(0) }}
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">{{ teller.teller_name }}</div>
                                        <small class="text-primary font-monospace">{{ teller.teller_code }}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="fw-medium text-dark">{{ teller.branch_name }}</div>
                                <div class="small text-muted text-uppercase" style="font-size: 0.7rem;">{{
                                    teller.designation }}</div>
                            </td>
                            <td>
                                <div class="fw-bold text-success">
                                    <small class="me-1">BDT</small>{{ teller.daily_cash_limit?.toLocaleString() }}
                                </div>
                            </td>
                            <td>
                                <span v-if="teller.status === 'active'"
                                    class="status-badge active">
                                    <span class="dot"></span> Active
                                </span>
                                <span v-else class="status-badge suspended">
                                    <span class="dot"></span> Suspended
                                </span>
                            </td>
                            <td class="text-end pe-4">
                                <div class="d-flex justify-content-end gap-2">
                                    <router-link :to="`/tellers/details/${teller.teller_id}`"
                                        class="btn btn-action btn-view" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </router-link>
                                    <router-link :to="`/tellers/edit/${teller.teller_id}`"
                                        class="btn btn-action btn-edit" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </router-link>
                                    <button class="btn btn-action btn-delete" @click="deleteTeller(teller.teller_id)"
                                        title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>

                        <tr v-if="!loading && tellers.length === 0">
                            <td colspan="6" class="text-center py-5">
                                <i class="fas fa-user-slash fa-3x text-light-emphasis mb-3"></i>
                                <p class="text-muted fw-medium">No tellers found in the record.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white py-3 border-top border-light" v-if="pagination">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="small text-muted">Showing page {{ page }}</span>
                    <ul class="pagination pagination-sm mb-0 gap-1">
                        <li class="page-item" :class="{ disabled: !pagination.prev_page_url }">
                            <button class="page-link rounded-pill border-0 bg-light px-3" @click="changePage(page - 1)">
                                Previous
                            </button>
                        </li>
                        <li class="page-item active">
                            <span class="page-link rounded-circle border-0 mx-1 bg-primary shadow-sm">{{ page }}</span>
                        </li>
                        <li class="page-item" :class="{ disabled: !pagination.next_page_url }">
                            <button class="page-link rounded-pill border-0 bg-light px-3" @click="changePage(page + 1)">
                                Next
                            </button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Page Layout */
.bg-light {
    background-color: #f8fafc !important;
}

/* Custom Table Design */
.custom-table thead th {
    background-color: #f1f5f9;
    color: #475569;
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.025em;
    font-weight: 700;
    padding: 1rem;
    border: none;
}

.custom-table tbody td {
    padding: 1.1rem 1rem;
    border-bottom: 1px solid #f1f5f9;
}

/* Avatar Box */
.avatar-box {
    width: 38px;
    height: 38px;
    background: #e0e7ff;
    color: #4338ca;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
    font-weight: 700;
    font-size: 0.9rem;
}

/* Status Badges */
.status-badge {
    display: inline-flex;
    align-items: center;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

.dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    margin-right: 8px;
}

.active {
    background: #ecfdf5;
    color: #065f46;
}

.active .dot {
    background: #10b981;
}

.suspended {
    background: #fff1f2;
    color: #9f1239;
}

.suspended .dot {
    background: #f43f5e;
}

/* Action Buttons */
.btn-action {
    width: 32px;
    height: 32px;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    border: none;
    transition: 0.2s ease;
}

.btn-view {
    background: #eff6ff;
    color: #2563eb;
}

.btn-view:hover {
    background: #2563eb;
    color: white;
}

.btn-edit {
    background: #fefce8;
    color: #ca8a04;
}

.btn-edit:hover {
    background: #ca8a04;
    color: white;
}

.btn-delete {
    background: #fff1f2;
    color: #e11d48;
}

.btn-delete:hover {
    background: #e11d48;
    color: white;
}

/* Form Controls */
.form-select,
.form-control {
    border-color: #e2e8f0;
    font-size: 0.9rem;
}

.form-control:focus,
.form-select:focus {
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    border-color: #2563eb;
}
</style>