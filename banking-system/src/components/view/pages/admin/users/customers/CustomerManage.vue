<script setup lang="ts">
import api from '@/config/config'
import { ref, onMounted, watch } from 'vue'


interface CustomerType {
    id: number
    customer_id: number
    customer_code: string
    customer_name: string
    branch_name: string
    phone: string
    accounts_count: number
    status: number | string
}

// Customer list
const customers = ref<CustomerType[]>([])
const loading = ref(false)

// Filters
const search = ref('')
const branch = ref('')
const status = ref('')

// Branches
const branches = ref<any[]>([])
api.get('/branches')
    .then(res => { branches.value = res.data.branches })
    .catch(() => { branches.value = [] })

// Pagination
const currentPage = ref(1)
const lastPage = ref(1)

// get customers 
const fetchCustomers = async (page = 1) => {
    loading.value = true
    try {
        const res = await api.get('customers' ,
        {
            params: {
                search: search.value,
                branch_id: branch.value,
                status: status.value,
                page: page
            }
        }
    )
        console.log(res.data);
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

// Initial fetch
onMounted(() =>{
    document.title = "Customer Management - Admin Dashboard"
    fetchCustomers();

})

// Watch filters
watch([search, branch, status], () => fetchCustomers(1))

// Change page
const changePage = (page: number) => {
    if (page >= 1 && page <= lastPage.value) {
        fetchCustomers(page)
    }
}
</script>

<template>
    <div class="container-lg container-fluid-md py-4">

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-0">
                    <i class="fas fa-users text-primary me-2"></i> Customers
                </h4>
                <small class="text-muted">Core Banking • Customer Management</small>
            </div>
            <router-link to="/customers/create" class="btn btn-primary">
                <i class="fas fa-user-plus me-1"></i> Add Customer
            </router-link>
        </div>

        <!-- Filter Card -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body">
                <div class="row g-3 align-items-end">
                    <!-- Search -->
                    <div class="col-md-4">
                        <label class="form-label">Search</label>
                        <input type="text" class="form-control" placeholder="Customer name / code / phone"
                            v-model="search" />
                    </div>

                    <!-- Branch -->
                    <div class="col-md-3">
                        <label class="form-label">Branch</label>
                        <select class="form-select" v-model="branch">
                            <option value="">All Branches</option>
                            <option v-for="b in branches" :key="b.branch_id" :value="b.branch_id">{{ b.branch_name }}
                            </option>
                        </select>
                    </div>

                    <!-- Status -->
                    <div class="col-md-3">
                        <label class="form-label">Status</label>
                        <select class="form-select" v-model="status">
                            <option value="">All</option>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>

                    <!-- Filter Button -->
                    <div class="col-md-2 text-end">
                        <button class="btn btn-outline-primary w-100" @click="fetchCustomers(1)">
                            <i class="fas fa-filter me-1"></i> Filter
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Card -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Customer</th>
                                <th>Phone</th>
                                <th>Branch</th>
                                <th>Accounts</th>
                                <th>Status</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <!-- Loading -->
                            <tr v-if="loading">
                                <td colspan="7" class="text-center py-4">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </td>
                            </tr>

                            <!-- Customers -->
                            <tr v-for="(c, index) in customers" :key="c.id">
                                <td>{{ (currentPage - 1) * 10 + index + 1 }}</td>
                                <td>
                                    <div class="fw-semibold">{{ c.customer_name ??'N/A' }}</div>
                                    <small class="text-muted">{{ c.customer_code ?? 'N/A' }}</small>
                                </td>
                                <td><i class="fas fa-phone text-muted me-1"></i> {{ c.phone ?? 'N/A' }}</td>
                                <td><i class="fas fa-building text-muted me-1"></i> {{ c.branch_name ?? 'N/A' }}</td>
                                <td>
                                    <span class="badge bg-info">
                                        <i class="fas fa-wallet me-1"></i> {{ c.accounts_count ?? 'N/A' }}
                                    </span>
                                </td>
                                <td v-if="c.status==='active'">
                                    <span class="badge bg-success">
                                        <i class="fas fa-check-circle text-white me-1"></i> Active
                                    </span>
                                </td>
                                <td v-else-if="c.status==='inactive'">
                                    <span class="badge bg-danger">
                                        <i class="fas fa-times-circle text-white me-1"></i> Inactive
                                    </span>
                                </td>
                                <td v-else="c.status==='closed'">
                                    <span class="badge bg-secondary">
                                        <i class="fas fa-lock-circle text-white me-1"></i> Closed
                                    </span>
                                </td>
                                <td class="text-end">
                                    <router-link :to="`/customers/${c.customer_id}/details`"
                                        class="btn btn-sm btn-outline-primary me-1">
                                        <i class="fas fa-eye"></i>
                                    </router-link>
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="fas fa-ban"></i>
                                    </button>
                                </td>
                            </tr>

                            <!-- Empty -->
                            <tr v-if="!loading && customers.length === 0">
                                <td colspan="7" class="text-center py-4 text-muted">
                                    <i class="fas fa-user-slash fa-2x mb-2"></i>
                                    <div>No customers found</div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <nav v-if="lastPage > 1" class="mt-3">
            <ul class="pagination justify-content-end">
                <li :class="['page-item', currentPage === 1 ? 'disabled' : '']">
                    <button class="page-link" @click="changePage(currentPage - 1)">Previous</button>
                </li>
                <li v-for="page in lastPage" :key="page" :class="['page-item', currentPage === page ? 'active' : '']">
                    <button class="page-link" @click="changePage(page)">{{ page }}</button>
                </li>
                <li :class="['page-item', currentPage === lastPage ? 'disabled' : '']">
                    <button class="page-link" @click="changePage(currentPage + 1)">Next</button>
                </li>
            </ul>
        </nav>

    </div>
</template>

<style scoped>
.table th {
    font-size: 0.85rem;
    text-transform: uppercase;
    color: #6c757d;
}

.table td {
    vertical-align: middle;
}

.card {
    border-radius: 0.75rem;
}

.badge {
    font-weight: 500;
}
</style>
