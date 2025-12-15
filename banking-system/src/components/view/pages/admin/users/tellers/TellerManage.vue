<script setup lang="ts">
import { defaultTellers, type TellersType } from '@/components/interfaces/teller.interfaces';
import { reactive } from 'vue';


    const tellers = reactive<TellersType[]>([defaultTellers]);

</script>


<template>
    <div class="container-lg container-fluid-md my-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">
                <i class="fas fa-user-tie me-2"></i>Teller Management
            </h2>
            <router-link to="/tellers/add" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Teller
            </router-link>
        </div>

        <!-- Search & Filter -->
        <div class="row mb-3">
            <div class="col-md-6">
                <input  type="text" class="form-control"
                    placeholder="Search teller by name, code or branch">
            </div>
            <div class="col-md-3">
                <select  class="form-select">
                    <option value="">All Branches</option>
                    
                </select>
            </div>
            <div class="col-md-3 text-end">
                <button class="btn btn-outline-secondary">
                    <i class="fas fa-filter"></i> Filter
                </button>
            </div>
        </div>

        <!-- Teller Table -->
        <div class="table-responsive shadow-sm rounded">
            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark text-uppercase">
                    <tr>
                        <th>#</th>
                        <th>Teller Code</th>
                        <th>Name</th>
                        <th>Branch</th>
                        <th>Designation</th>
                        <th>Daily Cash Limit</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <!-- <tbody>
                    <tr v-for="(teller, index) in filteredTellers" :key="teller.id">
                        <td>{{ index + 1 }}</td>
                        <td>{{ teller.teller_code }}</td>
                        <td>{{ teller.name }}</td>
                        <td>{{ teller.branch_name }}</td>
                        <td>{{ teller.designation }}</td>
                        <td>{{ formatCurrency(teller.daily_cash_limit) }}</td>
                        <td>
                            <span :class="['badge', teller.status == 'active' ? 'bg-success' : 'bg-danger']">
                                {{ teller.status }}
                            </span>
                        </td>
                        <td>
                            <router-link :to="`/tellers/view/${teller.id}`" class="btn btn-sm btn-info me-1">
                                <i class="fas fa-eye"></i>
                            </router-link>
                            <router-link :to="`/tellers/edit/${teller.id}`" class="btn btn-sm btn-warning me-1">
                                <i class="fas fa-edit"></i>
                            </router-link>
                            <button @click="deleteTeller(teller.id)" class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </tbody> -->
            </table>
        </div>

        <!-- Pagination Placeholder -->
        <div class="d-flex justify-content-end mt-3">
            <!-- You can integrate vue-pagination-next or custom pagination -->
        </div>

    </div>
</template>


<style scoped>
.table-hover tbody tr:hover {
    background-color: #f0f2f5;
}
</style>

<!-- Add Font Awesome in main index.html or App.vue -->
<!-- <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> -->
