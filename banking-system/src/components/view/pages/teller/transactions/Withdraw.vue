<script setup lang="ts">
import { onMounted, ref } from 'vue'
import api from '@/config/config'
import { useAuthStore } from '@/store/auth'

const accountNumber = ref('')
const customer = ref<any>(null)
const loading = ref(false)
const processing = ref(false)
const amount = ref<number | null>(null)
const narration = ref('')
const auth= useAuthStore();

onMounted(()=>{
    document.title = "Withdraw";
})

const findAccount = async () => {
    if (!accountNumber.value) return
    loading.value = true
    customer.value = null
    try {
        const res = await api.get(`/accounts/search?account_no=${accountNumber.value}`)
        console.log(res.data);
        if (res.data.success) {
            customer.value = res.data.account
        }
    } catch (error) {
        alert("Account not found or inactive!")
    } finally {
        loading.value = false
    }
}

const handleWithdraw = async () => {
    if (!amount.value || amount.value <= 0) {
        alert("Please enter a valid amount")
        return
    }
    if (amount.value > customer.value.balance) {
        alert("Insufficient balance in this account!")
        return
    }

    if (!confirm('Are you sure you want to process this withdrawal?')) return

    processing.value = true
    try {
        const res = await api.post('/transactions/withdraw', {
            id: customer.value.id,
            amount: amount.value,
            narration: narration.value
        })
        if (res.data.success) {
            alert("Withdrawal Successful!")
            customer.value = null
            accountNumber.value = ''
            amount.value = null
            narration.value = ''
        }
    } catch (error: any) {
        alert(error.response?.data?.message || "Transaction failed!")
    } finally {
        processing.value = false
    }
}
</script>

<template>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h4 class="fw-bold mb-4 text-danger"><i class="fas fa-money-bill-wave me-2"></i>Cash Withdrawal</h4>

                <div class="card border-0 shadow-lg rounded-4 mb-4">
                    <div class="card-body p-4">
                        <label class="form-label fw-bold">Enter Account Number</label>
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-white border-end-0"><i
                                    class="fas fa-search text-muted"></i></span>
                            <input v-model="accountNumber" type="text" class="form-control border-start-0 ps-0"
                                placeholder="Enter Account Number..." @keyup.enter="findAccount">
                            <button class="btn btn-danger px-4" @click="findAccount" :disabled="loading">
                                <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                                Find Account
                            </button>
                        </div>
                    </div>
                </div>

                <div v-if="customer" class="animate__animated animate__fadeIn">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
                        <div class="card-body p-0">
                            <div class="p-4 bg-danger text-white">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-lg bg-white text-danger rounded-circle me-3">
                                        <i class="fas fa-user-check fa-2x"></i>
                                    </div>
                                    <div>
                                        <h5 class="mb-0 fw-bold">{{ customer?.user_name }}</h5>
                                        <small class="opacity-75">A/C: {{ customer.account_number }} | Branch: {{
                                            customer.branch_name }}</small>
                                        <div class="mt-1">
                                            <span class="badge bg-white text-danger rounded-pill px-3 fw-bold">Active
                                                Account</span>
                                        </div>
                                    </div>
                                    <div class="ms-auto text-end">
                                        <small class="d-block opacity-75">Available Balance</small>
                                        <h4 class="fw-bold mb-0">BDT {{ customer.balance.toLocaleString() }}</h4>
                                    </div>
                                </div>
                            </div>

                            <div class="p-4 bg-white">
                                <div class="row g-4">
                                    <div class="col-md-12">
                                        <div class="alert alert-warning border-0 d-flex align-items-center mb-0">
                                            <i class="fas fa-exclamation-triangle me-3 fa-lg"></i>
                                            <small class="fw-medium">Please verify customer signature and identity
                                                before dispensing cash.</small>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Withdrawal Amount</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light fw-bold text-muted">BDT</span>
                                            <input v-model="amount" type="number"
                                                class="form-control form-control-lg fw-bold text-danger"
                                                placeholder="0.00" :max="customer?.balance">
                                        </div>
                                        <small v-if="amount && amount > customer?.balance"
                                            class="text-danger fw-bold mt-1 d-block">
                                            Amount exceeds available balance!
                                        </small>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Voucher/Slip Number</label>
                                        <input type="text" class="form-control form-control-lg"
                                            placeholder="Slip Ref No.">
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label fw-bold">Narration / Remarks</label>
                                        <textarea v-model="narration" class="form-control" rows="2"
                                            placeholder="Write any specific notes here..."></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="card-footer bg-light border-0 p-4">
                                <button class="btn btn-danger btn-lg w-100 rounded-pill shadow-sm py-3 fw-bold"
                                    @click="handleWithdraw" :disabled="processing || (amount ?? 0) > customer.balance">
                                    <span v-if="processing" class="spinner-border spinner-border-sm me-2"></span>
                                    <i v-else class="fas fa-hand-holding-usd me-2"></i> Confirm & Dispense Cash
                                </button>
                                <p class="text-center text-muted small mt-3 mb-0">
                                    Transaction will be recorded under your Teller ID: <strong>#{{ auth?.user?.id ||
                                        'Active' }}</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.avatar-lg {
    width: 65px;
    height: 65px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.animate__fadeIn {
    animation-duration: 0.4s;
}

.input-group-text {
    border-color: #dee2e6;
}

input:focus {
    border-color: #dc3545;
    box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.1);
}
</style>