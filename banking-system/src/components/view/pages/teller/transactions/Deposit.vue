<script setup lang="ts">
import { ref } from 'vue'
import api from '@/config/config'

const accountNumber = ref('')
const customer = ref<any>(null)
const loading = ref(false)
const processing = ref(false)
const amount = ref<number | null>(null)
const narration = ref('')

const findAccount = async () => {
    if (!accountNumber.value) return
    loading.value = true
    customer.value = null
    try {
        const res = await api.get(`accounts/search?account_no=${accountNumber.value}`)
        console.log(res.data);
        if (res.data.success) {
            customer.value = res.data.account
        }
    } catch (error) {
        console.log(error);
        alert("Account not found or invalid!")
    } finally {
        loading.value = false
    }
}

const handleDeposit = async () => {
    if (!amount.value || amount.value <= 0) return
    processing.value = true
    try {
        const res = await api.post('transactions/deposit', {
            id: customer.value.id,
            amount: amount.value,
            narration: narration.value
        })
        console.log(res.data);
        if (res.data.success) {
            alert("Deposit Successful!")
            customer.value = null
            accountNumber.value = ''
            amount.value = null
        }
    } catch (error) {
        console.log(error);
        alert("Transaction failed!")
    } finally {
        processing.value = false
    }
}
</script>

<template>
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h4 class="fw-bold mb-4"><i class="fas fa-piggy-bank me-2 text-success"></i>Cash Deposit</h4>

                <div class="card border-0 shadow-lg rounded-4 mb-4">
                    <div class="card-body p-4">
                        <label class="form-label fw-bold">Enter Account Number</label>
                        <div class="input-group input-group-lg">
                            <input v-model="accountNumber" type="text" class="form-control" placeholder="e.g. ACC-100293847"
                                @keyup.enter="findAccount">
                            <button class="btn btn-dark px-4" @click="findAccount" :disabled="loading">
                                <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                                <i v-else class="fas fa-search me-2"></i> Find
                            </button>
                        </div>
                    </div>
                </div>

                <div v-if="customer" class="animate__animated animate__fadeIn">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
                        <div class="card-body p-0">
                            <div class="p-4 bg-success text-white">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-lg bg-white text-success rounded-circle me-3">
                                        <i class="fas fa-user fa-2x"></i>
                                    </div>
                                    <div>
                                        <h5 class="mb-0 fw-bold">{{ customer?.user_name }}</h5>
                                        <small class="opacity-75">A/C: {{ customer?.account_no }} | {{
                                            customer?.branch_name }}</small>
                                    </div>
                                    <div class="ms-auto text-end">
                                        <small class="d-block opacity-75">Current Balance</small>
                                        <h4 class="fw-bold mb-0">BDT {{ customer?.balance.toLocaleString() }}</h4>
                                    </div>
                                </div>
                            </div>

                            <div class="p-4 bg-white">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Deposit Amount</label>
                                        <div class="input-group">
                                            <span class="input-group-text">BDT</span>
                                            <input v-model="amount" type="number" class="form-control form-control-lg"
                                                placeholder="0.00">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Depositor Name (Optional)</label>
                                        <input type="text" class="form-control form-control-lg"
                                            placeholder="Self / Others">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold">Narration</label>
                                        <textarea v-model="narration" class="form-control" rows="2"
                                            placeholder="Reason for deposit..."></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-light border-0 p-4">
                                <button class="btn btn-success btn-lg w-100 rounded-pill shadow-sm"
                                    @click="handleDeposit" :disabled="processing">
                                    <i class="fas fa-check-circle me-2"></i> Confirm Cash Deposit
                                </button>
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
    width: 60px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.animate__fadeIn {
    animation-duration: 0.5s;
}
</style>