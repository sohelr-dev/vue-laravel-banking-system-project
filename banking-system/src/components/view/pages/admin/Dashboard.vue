<script setup lang="ts">
import { onMounted, ref } from 'vue'
const stats = ref([
    { title: 'Total Customers', value: '12,450', icon: 'fas fa-users', color: 'primary', growth: '+12%' },
    { title: 'Total Deposits', value: 'BDT 8.5M', icon: 'fas fa-piggy-bank', color: 'success', growth: '+5.4%' },
    { title: 'Active Loans', value: 'BDT 2.1M', icon: 'fas fa-hand-holding-usd', color: 'warning', growth: '-2%' },
    { title: 'Branch Profit', value: 'BDT 1.2M', icon: 'fas fa-chart-line', color: 'info', growth: '+8%' }
])

const branchPerformance = ref([
    { name: 'Dhaka Main', customers: 4500, status: 'High' },
    { name: 'Chittagong South', customers: 2100, status: 'Medium' },
    { name: 'Sylhet East', customers: 1200, status: 'Low' }
])
onMounted(()=>{
    document.title= "Dashboard | Admin";
})
</script>

<template>
    <div class="admin-dashboard py-4 px-3 px-lg-5 bg-light min-vh-100">

        <div class="row align-items-center mb-4">
            <div class="col">
                <h3 class="fw-bold text-dark-emphasis mb-1">Executive Overview</h3>
                <p class="text-muted small">System-wide performance and branch analytics</p>
            </div>
            <div class="col-auto">
                <div class="dropdown">
                    <button class="btn btn-white shadow-sm dropdown-toggle rounded-3" type="button"
                        data-bs-toggle="dropdown">
                        <i class="far fa-calendar-alt me-2"></i> This Fiscal Year
                    </button>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div v-for="stat in stats" :key="stat.title" class="col-md-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 overflow-hidden stat-card">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between mb-3">
                            <div :class="`icon-shape bg-${stat.color}-subtle text-${stat.color}`">
                                <i :class="stat.icon"></i>
                            </div>
                            <span
                                :class="`badge rounded-pill bg-${stat.growth.startsWith('+') ? 'success' : 'danger'}-subtle text-${stat.growth.startsWith('+') ? 'success' : 'danger'} d-flex align-items-center`"
                                style="height: fit-content;">
                                {{ stat.growth }}
                            </span>
                        </div>
                        <h6 class="text-muted fw-bold small text-uppercase mb-1">{{ stat.title }}</h6>
                        <h3 class="fw-bold mb-0 text-dark-emphasis">{{ stat.value }}</h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div
                        class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center pt-4 px-4">
                        <h5 class="mb-0 fw-bold">Deposit vs Withdrawal Trends</h5>
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-outline-secondary active">Monthly</button>
                            <button class="btn btn-outline-secondary">Weekly</button>
                        </div>
                    </div>
                    <div class="card-body p-4 d-flex align-items-center justify-content-center bg-light-subtle rounded-bottom-4 m-3 mt-0"
                        style="min-height: 300px; border: 2px dashed #e2e8f0;">
                        <div class="text-center">
                            <i class="fas fa-chart-area fa-3x text-light-emphasis mb-3"></i>
                            <p class="text-muted">Chart.js or ApexCharts will be rendered here</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white py-3 border-0 pt-4 px-4">
                        <h5 class="mb-0 fw-bold">Branch Performance</h5>
                    </div>
                    <div class="card-body px-4">
                        <div v-for="branch in branchPerformance" :key="branch.name"
                            class="branch-item py-3 border-bottom border-light d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="mb-0 fw-bold">{{ branch.name }}</h6>
                                <small class="text-muted">{{ branch.customers }} Active Customers</small>
                            </div>
                            <span
                                :class="['badge rounded-pill', branch.status === 'High' ? 'bg-success' : branch.status === 'Medium' ? 'bg-info' : 'bg-warning']">
                                {{ branch.status }}
                            </span>
                        </div>
                        <button class="btn btn-light w-100 mt-4 rounded-3 fw-bold text-muted">View All Branches</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white py-3 border-bottom border-light px-4">
                        <h5 class="mb-0 fw-bold text-dark">Recent System Activity</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-middle mb-0 custom-admin-table">
                            <thead>
                                <tr>
                                    <th class="ps-4">Action</th>
                                    <th>User Role</th>
                                    <th>Branch</th>
                                    <th>Timestamp</th>
                                    <th class="text-end pe-4">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="ps-4">
                                        <div class="d-flex align-items-center">
                                            <div class="activity-icon bg-blue-subtle text-primary me-3"><i
                                                    class="fas fa-user-plus"></i></div>
                                            <span class="fw-medium">New Customer Registered</span>
                                        </div>
                                    </td>
                                    <td><span class="text-muted small">Teller (ID: #44)</span></td>
                                    <td><span class="fw-medium">Dhaka Main</span></td>
                                    <td class="text-muted small">2 mins ago</td>
                                    <td class="text-end pe-4"><span
                                            class="badge bg-success-subtle text-success">Success</span></td>
                                </tr>
                                <tr>
                                    <td class="ps-4">
                                        <div class="d-flex align-items-center">
                                            <div class="activity-icon bg-red-subtle text-danger me-3"><i
                                                    class="fas fa-exclamation-triangle"></i></div>
                                            <span class="fw-medium">Failed Vault Synchronization</span>
                                        </div>
                                    </td>
                                    <td><span class="text-muted small">System Admin</span></td>
                                    <td><span class="fw-medium">Sylhet East</span></td>
                                    <td class="text-muted small">15 mins ago</td>
                                    <td class="text-end pe-4"><span
                                            class="badge bg-danger-subtle text-danger">Alert</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.bg-light {
    background-color: #f6f9fc !important;
}

.icon-shape {
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    font-size: 1.25rem;
}

.activity-icon {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.85rem;
}

.stat-card {
    transition: all 0.3s ease;
    border: 1px solid transparent !important;
}

.stat-card:hover {
    transform: translateY(-5px);
    border-color: #e2e8f0 !important;
}

.custom-admin-table thead th {
    background-color: #f8fafc;
    color: #64748b;
    font-size: 0.7rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    padding: 1rem;
    border: none;
}

.custom-admin-table tbody td {
    padding: 1rem;
    border-bottom: 1px solid #f1f5f9;
    font-size: 0.85rem;
}

.btn-white {
    background: white;
    border: 1px solid #e2e8f0;
    color: #475569;
}
</style>