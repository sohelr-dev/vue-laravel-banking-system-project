<script setup lang="ts">
import api from '@/config/config'
import { useAuthStore } from '@/store/auth'
import { ref, onMounted, watch } from 'vue'

interface CustomerType {
    id: number
    customer_id: number
    customer_code: string
    customer_name: string
    branch_name: string
    phone: string
    accounts_count: number
    status: string // 'active' | 'inactive' | 'closed'
}

const customers = ref<CustomerType[]>([])
const loading = ref(false)
const search = ref('')
const branch = ref('')
const status = ref('')
const branches = ref<any[]>([])
const currentPage = ref(1)
const lastPage = ref(1)

// Fetch Branches
const fetchBranches = async () => {
    try {
        const res = await api.get('/branches')
        branches.value = res.data.branches
    } catch (error) {
        console.error("Branch fetch failed")
    }
}

// Fetch Customers 
const fetchCustomers = async (page = 1) => {
    loading.value = true
    try {
        const res = await api.get('customers', {
            params: {
                search: search.value,
                branch_id: branch.value,
                status: status.value,
                page: page
            }
        })
        customers.value = res.data.customers.data
        currentPage.value = res.data.customers.current_page
        lastPage.value = res.data.customers.last_page
    } catch (err) {
        customers.value = []
        currentPage.value = 1
        lastPage.value = 1
    } finally {
        loading.value = false
    }
}

const auth =useAuthStore();
const role= auth.user?.role_id;
// console.log(role);

onMounted(() => {
    document.title = "Customer Management - Admin "
    fetchBranches()
    fetchCustomers()
})

watch([search, branch, status], () => fetchCustomers(1))

const changePage = (page: number) => {
    if (page >= 1 && page <= lastPage.value) {
        fetchCustomers(page)
    }
}
</script>

<template>
    <div class="page-content py-4 px-3 px-lg-5 bg-light min-vh-100">
        <div class="row align-items-center mb-4">
            <div class="col">
                <h3 class="fw-bold text-dark-emphasis mb-1">Customer Database</h3>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item text-primary">Core Banking</li>
                        <li class="breadcrumb-item active">Management</li>
                    </ol>
                </nav>
            </div>
            <div class="col-auto" v-if="role==1">
                <router-link to="/customers/add" class="btn btn-primary shadow-sm px-4 rounded-pill">
                    <i class="fas fa-plus-circle me-2"></i>New Customer
                </router-link>
            </div>
            <div class="col-auto" v-if="role==2">
                <router-link to="/customer-accounts/add" class="btn btn-primary shadow-sm px-4 rounded-pill">
                    <i class="fas fa-plus-circle me-2"></i>New Customer
                </router-link>
            </div>
        </div>

        <div class="card border-0 shadow-sm mb-4 rounded-4">
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-lg-4">
                        <div class="input-group input-group-merge">
                            <span class="input-group-text bg-light border-end-0 text-muted">
                                <i class="fas fa-search"></i>
                            </span>
                            <input type="text" class="form-control bg-light border-start-0 ps-0"
                                placeholder="Search name, code or phone..." v-model="search" />
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <select class="form-select bg-light" v-model="branch">
                            <option value="">All Branches</option>
                            <option v-for="b in branches" :key="b.branch_id" :value="b.branch_id">
                                {{ b.branch_name }}
                            </option>
                        </select>
                    </div>
                    <div class="col-lg-3">
                        <select class="form-select bg-light" v-model="status">
                            <option value="">All Status</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <button class="btn btn-dark w-100 rounded-3" @click="fetchCustomers(1)">
                            <i class="fas fa-sliders-h me-2"></i>Apply
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-header bg-white py-3 border-bottom border-light">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Customer Records</h5>
                    <span class="badge bg-primary-subtle text-primary rounded-pill px-3 py-2">
                        Total: {{ customers.length }}
                    </span>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 custom-table">
                        <thead class="bg-light-subtle">
                            <tr>
                                <th class="ps-4">#ID</th>
                                <th>Customer Info</th>
                                <th>Contact Details</th>
                                <th>Branch</th>
                                <th>Accounts</th>
                                <th>Status</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-if="loading">
                                <td colspan="7" class="text-center py-5">
                                    <div class="spinner-grow text-primary spinner-grow-sm me-2"></div>
                                    <span class="text-muted fw-medium">Loading records...</span>
                                </td>
                            </tr>

                            <tr v-for="(c, index) in customers" :key="c.id">
                                <td class="ps-4 text-muted small">
                                    #{{ (currentPage - 1) * 10 + index + 1 }}
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-initals me-3 text-primary bg-primary-subtle">
                                            {{ c.customer_name?.charAt(0) }}
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark">{{ c.customer_name }}</div>
                                            <code class="text-muted small">{{ c.customer_code }}</code>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="small fw-medium"><i class="fas fa-phone-alt me-2 text-muted"></i>{{
                                        c.phone }}</div>
                                </td>
                                <td>
                                    <span class="text-secondary small fw-medium">
                                        <i class="fas fa-building me-1 opacity-50 text-primary"></i> {{ c.branch_name }}
                                    </span>
                                </td>
                                <td>
                                    <div class="account-pill">
                                        {{ c.accounts_count }} Accounts
                                    </div>
                                </td>
                                <td>
                                    <span v-if="c.status === 'active'" class="status-badge active">
                                        <span class="dot"></span> Active
                                    </span>
                                    <span v-else-if="c.status === 'inactive'" class="status-badge inactive">
                                        <span class="dot"></span> Inactive
                                    </span>
                                    <span v-else class="status-badge closed">
                                        <span class="dot"></span> Closed
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-flex justify-content-end gap-2" v-if="role==1">
                                        <router-link :to="`/customers/${c.customer_id}/details`"
                                            class="btn btn-icon-sm btn-light-primary" title="View Details">
                                            <i class="fas fa-eye text-primary"></i>
                                        </router-link>
                                        <button class="btn btn-icon-sm btn-light-danger" title="Suspend">
                                            <i class="fas fa-ban text-danger"></i>
                                        </button>
                                    </div>
                                    <div class="d-flex justify-content-end gap-2" v-if="role==2">
                                        <router-link :to="`/customer-accounts/${c.customer_id}/details`"
                                            class="btn btn-icon-sm btn-light-primary" title="View Details">
                                            <i class="fas fa-eye text-primary"></i>
                                        </router-link>
                                        <button class="btn btn-icon-sm btn-light-danger" title="Suspend">
                                            <i class="fas fa-ban text-danger"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>

                            <tr v-if="!loading && customers.length === 0">
                                <td colspan="7" class="text-center py-5">
                                    <div class="empty-state">
                                        <i class="fas fa-folder-open fa-3x text-light-emphasis mb-3"></i>
                                        <p class="text-muted fw-medium">No results found for your search.</p>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white py-3 border-top border-light">
                <nav class="d-flex justify-content-between align-items-center">
                    <span class="small text-muted fw-medium">Page {{ currentPage }} of {{ lastPage }}</span>
                    <ul class="pagination pagination-sm mb-0 gap-1">
                        <li class="page-item" :class="{ disabled: currentPage === 1 }">
                            <button class="page-link rounded-circle border-0 bg-light"
                                @click="changePage(currentPage - 1)">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                        </li>
                        <li v-for="page in lastPage" :key="page" class="page-item">
                            <button class="page-link rounded-circle border-0 mx-1"
                                :class="currentPage === page ? 'bg-primary text-white shadow-sm' : 'bg-light text-dark'"
                                @click="changePage(page)">{{ page }}</button>
                        </li>
                        <li class="page-item" :class="{ disabled: currentPage === lastPage }">
                            <button class="page-link rounded-circle border-0 bg-light"
                                @click="changePage(currentPage + 1)">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Table Styling */
.custom-table thead th {
    font-weight: 600;
    font-size: 0.75rem;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    color: #6c757d;
    padding: 1.25rem 1rem;
    border-bottom: 1px solid #f0f2f5;
}

.custom-table tbody td {
    padding: 1rem;
    font-size: 16px;
    color: #495057;
}

/* Avatar Initials */
.avatar-initals {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    font-weight: 700;
    font-size: 1rem;
}

/* Account Pill */
.account-pill {
    background: #f8f9fa;
    border: 1px solid #e9ecef;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    display: inline-block;
}

/* Status Badges Styling */
.status-badge {
    display: inline-flex;
    align-items: center;
    padding: 5px 12px;
    border-radius: 30px;
    font-size: 0.75rem;
    font-weight: 600;
}

.dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    margin-right: 8px;
}

.status-badge.active {
    background-color: #e8f5e9;
    color: #2e7d32;
}

.status-badge.active .dot {
    background-color: #2e7d32;
}

.status-badge.inactive {
    background-color: #ffebee;
    color: #c62828;
}

.status-badge.inactive .dot {
    background-color: #c62828;
}

.status-badge.closed {
    background-color: #f5f5f5;
    color: #616161;
}

.status-badge.closed .dot {
    background-color: #616161;
}

/* Buttons */
.btn-icon-sm {
    width: 32px;
    height: 32px;
    padding: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    border: none;
    transition: all 0.2s;
}

.btn-light-primary {
    background: #e7f1ff;
}

.btn-light-primary:hover {
    background: #0d6efd;
}

.btn-light-primary:hover i {
    color: white !important;
}

.btn-light-danger {
    background: #fff0f0;
}

.btn-light-danger:hover {
    background: #dc3545;
}

.btn-light-danger:hover i {
    color: white !important;
}

/* Page Background */
.bg-light {
    background-color: #f4f7fa !important;
}
</style>