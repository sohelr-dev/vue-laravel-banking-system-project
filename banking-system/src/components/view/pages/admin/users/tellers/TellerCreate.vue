<script setup lang="ts">
import { ref, onMounted } from 'vue';
import api from '@/config/config';
import { useRouter } from 'vue-router';
import type { BranchType } from '@/components/interfaces/branch.interfaces';
import type { TellerType } from '@/components/interfaces/teller.interfaces';
import { useAuthStore } from '@/store/auth';

const router = useRouter();
const loading = ref(false);
const errors = ref<Record<string, string>>({});
const auth =useAuthStore();
const user_id = auth.user?.id || 0;

const form = ref<any>({
    name: '',
    email: '',
    phone: '',
    password: '',
    branch_id: 0,
    auth_id: user_id ?? 0,
    daily_cash_limit: 0
});

const branches = ref<BranchType[]>([]);

const fetchBranches = async () => {
    api.get('branches').then((res)=>{
        // console.log(res.data);
        branches.value = res.data.branches || [];
    }).catch((e)=>{
        console.log(e);
    });
};

const submitForm = async () => {
    // console.log(form.value);
    loading.value = true;
    errors.value = {};

    try {
        await api.post('tellers/create',form.value);
        alert('Teller created successfully');
        router.push('/tellers');
    } catch (e: any) {
        if (e.response?.data?.errors) {
            errors.value = e.response.data.errors;
            // console.log(e.response.data);
        }
    } finally {
        loading.value = false;
    }
};


onMounted(fetchBranches);
</script>

<template>
    <div class="container-lg my-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            
            <div>
                <h3 class="fw-bold mb-0"><i class="fas fa-user-plus me-2"></i>Add Teller</h3>
                <small class="text-muted">Core Banking • Teller Management</small>
            </div>
            <button class="btn btn-outline-secondary" @click="router.back()">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow border-0">
                    <div class="card-header fw-semibold bg-primary text-white">
                        Teller Registration Form
                    </div>

                    <div class="card-body">
                        <form @submit.prevent="submitForm" class="row g-3">
                            <input type="hidden" v-model="form.user_id">

                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input v-model="form.name" type="text" class="form-control" />
                                <small class="text-danger">{{ errors.name }}</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input v-model="form.email" type="email" class="form-control" />
                                <small class="text-danger">{{ errors.email }}</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Phone</label>
                                <input v-model="form.phone" type="text" class="form-control" />
                                <small class="text-danger">{{ errors.phone }}</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <input v-model="form.password" type="password" class="form-control" />
                                <small class="text-danger">{{ errors.password }}</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Branch</label>
                                <select v-model="form.branch_id" class="form-select">
                                    <option value="">Select Branch</option>
                                    <option v-for="b in branches" :key="b.id" :value="b.id">
                                        {{ b.name }}
                                    </option>
                                </select>
                                <small class="text-danger">{{ errors.branch_id }}</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Daily Cash Limit</label>
                                <input v-model="form.daily_cash_limit" type="number" class="form-control" />
                                <small class="text-danger">{{ errors.daily_cash_limit }}</small>
                            </div>

                            <div class="col-12 text-end mt-3">
                                <button class="btn btn-primary px-4" :disabled="loading">
                                    <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                                    Create Teller
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<style scoped>
.card {
    border-radius: 0.75rem;
}
</style>