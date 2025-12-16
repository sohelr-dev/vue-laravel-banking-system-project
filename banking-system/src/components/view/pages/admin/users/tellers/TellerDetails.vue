<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import api from '@/config/config';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();
const tellerId = route.params.id;

const loading = ref(true);
const error = ref('');
const teller = ref<any>(null);

const statusBadge = (status: any) => {
    return status === 'active' || status === 1
        ? 'badge bg-success-subtle text-success'
        : 'badge bg-danger-subtle text-danger';
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
    <div class="container-lg my-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-0"><i class="fas fa-user-tie me-2"></i>Teller Profile</h3>
                <small class="text-muted">Core Banking • Teller Module</small>
            </div>
            <button class="btn btn-outline-secondary" @click="router.back()">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>

        <!-- Loading -->
        <div v-if="loading" class="d-flex justify-content-center py-5">
            <div class="text-center">
                <div class="spinner-border text-primary mb-3"></div>
                <div class="fw-semibold text-muted">Loading teller profile...</div>
            </div>
        </div>

        <!-- Error -->
        <div v-else-if="error" class="alert alert-danger text-center">{{ error }}</div>

        <!-- Content -->
        <div v-else class="row g-4">

            <!-- Teller Info -->
            <div class="col-lg-4">
                <div class="card shadow border-0 h-100">
                    <div class="card-body text-center">
                        <div class="avatar bg-primary text-white rounded-circle mb-3">
                            {{ teller.teller_name.charAt(0) }}
                        </div>
                        <h5 class="fw-bold mb-1">{{ teller.teller_name }}</h5>
                        <div class="text-muted mb-2">{{ teller.designation }}</div>
                        <span :class="statusBadge(teller.status)">{{ teller.status }}</span>

                        <hr />
                        <div class="text-start small">
                            <p><i class="fas fa-id-badge me-2"></i>{{ teller.teller_code }}</p>
                            <p><i class="fas fa-envelope me-2"></i>{{ teller.email }}</p>
                            <p><i class="fas fa-phone me-2"></i>{{ teller.phone }}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Branch & Meta -->
            <div class="col-lg-8">
                <div class="row g-4">

                    <!-- Branch -->
                    <div class="col-md-6">
                        <div class="card shadow border-0 h-100">
                            <div class="card-header fw-semibold">Branch Information</div>
                            <div class="card-body small">
                                <p><strong>Name:</strong> {{ teller.branch_name }}</p>
                                <p><strong>Code:</strong> {{ teller.branch_code }}</p>
                                <p><strong>Phone:</strong> {{ teller.branch_phone }}</p>
                                <span :class="statusBadge(teller.branch_status)">
                                    {{ teller.branch_status }}
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Meta -->
                    <div class="col-md-6">
                        <div class="card shadow border-0 h-100">
                            <div class="card-header fw-semibold">User Meta</div>
                            <div class="card-body small">
                                <p><strong>Account No:</strong> {{ teller.user_meta.account_no }}</p>
                                <p><strong>Branch:</strong> {{ teller.user_meta.branch }}</p>
                                <p><strong>Balance:</strong> {{ teller.user_meta.balance }}</p>
                                <p class="text-danger"><strong>Note:</strong> {{ teller.user_meta.reason }}</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.avatar {
    width: 72px;
    height: 72px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.75rem;
}
</style>