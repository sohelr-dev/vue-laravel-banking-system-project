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
    status: number | string
}

const tellers = ref<TellerType[]>([])
const loading = ref(false)

// filters
const search = ref('')
const branch_id = ref('')
const status = ref('')
const page = ref(1)

// pagination meta
const pagination = ref<any>(null)

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

onMounted(fetchTellers)

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
    <div class="container-lg container-fluid-md my-4">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">
                <i class="fas fa-user-tie me-2"></i>Teller Management
            </h2>
            <router-link to="/tellers/add" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Teller
            </router-link>
        </div>

        <!-- Search & Filter -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <div class="row g-2">
                    <div class="col-md-4">
                        <input v-model="search" type="text" class="form-control"
                            placeholder="Search by teller name or code" />
                    </div>
                    <div class="col-md-4">
                        <select v-model="branch_id" class="form-select">
                            <option value="">All Branches</option>
                            <!-- branch options -->
                        </select>
                    </div>
                    <div class="col-md-4">
                        <select v-model="status" class="form-select">
                            <option value="">All Status</option>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table -->
        <div class="card shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark text-uppercase">
                        <tr>
                            <th>#</th>
                            <th>Teller Code</th>
                            <th>Name</th>
                            <th>Branch</th>
                            <th>Designation</th>
                            <th>Daily Cash Limit</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                       <tr v-if="loading">
                            <td colspan="8" class="py-5 text-center">
                                <div class="d-flex flex-column align-items-center justify-content-center">
                                    <div class="spinner-border text-primary mb-2" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                    <span class="fw-semibold text-secondary">
                                        Loading teller information, please wait…
                                    </span>
                                </div>
                            </td>
                        </tr>

                        <tr v-for="teller in tellers" :key="teller.teller_id">
                            <td>{{ teller.teller_id ?? 'N/A' }}</td>
                            <td>{{ teller.teller_code ?? 'N/A' }}</td>
                            <td>{{ teller.teller_name ?? 'N/A' }}</td>
                            <td>{{ teller.branch_name ?? 'N/A' }}</td>
                            <td>{{ teller.designation ?? 'N/A' }}</td>
                            <td>{{ teller.daily_cash_limit ?? 'N/A' }}</td>
                            <td v-if="teller.status=='active'">
                                <span class="badge bg-success">Active</span>
                            </td>
                            <td v-else-if="teller.status=='suspended'">
                                <span class="badge bg-secondary">Suspended</span> 
                            </td>
                            <td class="text-end">
                                <router-link :to="`/tellers/details/${teller.teller_id}`" class="btn btn-sm btn-info me-1">
                                    <i class="fas fa-eye"></i>
                                </router-link>
                                <!-- `/tellers/edit/${teller.teller_id}` -->
                                <router-link to=""
                                    class="btn btn-sm btn-warning me-1">
                                    <i class="fas fa-edit"></i>
                                </router-link>
                                <button class="btn btn-sm btn-danger" @click="deleteTeller(teller.teller_id)">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="card-footer d-flex justify-content-end" v-if="pagination">
                <nav>
                    <ul class="pagination mb-0">
                        <li class="page-item" :class="{ disabled: !pagination.prev_page_url }">
                            <button class="page-link" @click="changePage(page - 1)">
                                Prev
                            </button>
                        </li>
                        <li class="page-item active">
                            <span class="page-link">{{ pagination.current_page }}</span>
                        </li>
                        <li class="page-item" :class="{ disabled: !pagination.next_page_url }">
                            <button class="page-link" @click="changePage(page + 1)">
                                Next
                            </button>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</template>

<style scoped>
.table-hover tbody tr:hover {
    background-color: #f0f2f5;
}
</style>