<script setup lang="ts">
import { ref, onMounted } from 'vue';
import api from '@/config/config';
import Swal from 'sweetalert2';
import { useRouter } from 'vue-router';

const router = useRouter();
const loading = ref(false);
const accounts = ref<any[]>([]);

// Form Data
const transferData = ref({
    from_account_id: '',
    to_account_no: '',
    amount: null,
    narration: ''
});

// Receiver Info (Auto-fetch)
const receiverName = ref('');
const verifyingReceiver = ref(false);

const fetchAccounts = async () => {
    try {
        const res = await api.get('customer/dashboard');
        accounts.value = res.data.data.accounts;
    } catch (error) {
        console.error("Account load failed");
    }
};

// একাউন্ট নাম্বার লিখলে নাম অটো চেক করার লজিক
const verifyReceiver = async () => {
    if (transferData.value.to_account_no.length < 10) return;

    verifyingReceiver.value = true;
    try {
        const res = await api.get(`customer/verify-account/${transferData.value.to_account_no}`);
        receiverName.value = res.data.account_holder_name;
    } catch (e) {
        receiverName.value = 'Account not found!';
    } finally {
        verifyingReceiver.value = false;
    }
};

const handleTransfer = async () => {
    // Validation
    if (!transferData.value.from_account_id || !transferData.value.to_account_no || !transferData.value.amount) {
        Swal.fire('Error', 'Please fill all required fields', 'error');
        return;
    }

    const result = await Swal.fire({
        title: 'Are you sure?',
        text: `You are sending ৳${transferData.value.amount} to ${receiverName.value}`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, Transfer'
    });

    if (result.isConfirmed) {
        loading.value = true;
        try {
            const res = await api.post('customer/transfer', transferData.value);
            if (res.data.success) {
                await Swal.fire('Success', 'Transfer Completed Successfully!', 'success');
                router.push('/customer/dashboard'); // ট্রান্সফার শেষে ড্যাশবোর্ডে পাঠাবে
            }
        } catch (error: any) {
            Swal.fire('Failed', error.response?.data?.message || 'Transaction failed', 'error');
        } finally {
            loading.value = false;
        }
    }
};

onMounted(fetchAccounts);
</script>

<template>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4 p-lg-5">
                        <h4 class="fw-bold text-navy mb-4 text-center">Internal Fund Transfer</h4>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Select Your Account</label>
                            <select v-model="transferData.from_account_id" class="form-select form-select-lg rounded-3">
                                <option value="" disabled>Choose account</option>
                                <option v-for="acc in accounts" :key="acc.id" :value="acc.id">
                                    {{ acc.account_no }} (Balance: ৳{{ acc.balance }})
                                </option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Recipient Account Number</label>
                            <div class="input-group">
                                <input v-model="transferData.to_account_no" @input="verifyReceiver" type="text"
                                    class="form-control form-control-lg rounded-3" placeholder="Enter account number">
                            </div>
                            <div v-if="receiverName" class="mt-2 small px-2 py-1 rounded"
                                :class="receiverName === 'Account not found!' ? 'bg-danger-subtle text-danger' : 'bg-success-subtle text-success'">
                                <i class="fas fa-user-check me-1"></i> {{ receiverName }}
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-muted">Amount (BDT)</label>
                            <input v-model="transferData.amount" type="number"
                                class="form-control form-control-lg rounded-3" placeholder="0.00">
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-muted">Note (Optional)</label>
                            <input v-model="transferData.narration" type="text" class="form-control rounded-3"
                                placeholder="e.g. Gift, Payment">
                        </div>

                        <button @click="handleTransfer" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold"
                            :disabled="loading || !receiverName || receiverName === 'Account not found!'">
                            <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                            Proceed to Transfer
                        </button>

                        <div class="text-center mt-3">
                            <router-link to="/customer/dashboard" class="text-decoration-none small text-muted">Cancel
                                and go back</router-link>
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

.btn-primary {
    background-color: #1a237e;
    border: none;
}

.btn-primary:hover {
    background-color: #3949ab;
}

.form-control:focus,
.form-select:focus {
    box-shadow: none;
    border-color: #1a237e;
}
</style>