<script setup lang="ts">
import { ref, onMounted } from 'vue'
import api from '@/config/config'

const tellers = ref<any[]>([])
const loading = ref(false)
const processing = ref(false)


const showModal = ref(false)
const selectedTeller = ref<any>(null)
const loadAmount = ref<number | null>(null)


const fetchTellers = async () => {
    loading.value = true
    try {
        const res = await api.get('tellers')
        console.log(res.data.tellers);
        tellers.value = res.data.tellers.data
    } catch (error) {
        console.error("Failed to load tellers")
    } finally {
        loading.value = false
    }
}

const openLoadModal = (teller: Number) => {
    selectedTeller.value = teller
    // console.log(teller);
    showModal.value = true
}

const submitCashLoad = async () => {
    if (!loadAmount.value || loadAmount.value <= 0) return

    processing.value = true
    try {
        // console.log(loadAmount.value);
        const res = await api.post('admin/load-cash', {
            teller_id: selectedTeller.value,
            amount: loadAmount.value
        })

        if (res.data.success) {
            alert("Cash loaded successfully!")
            showModal.value = false
            loadAmount.value = null
            fetchTellers() 
        }
    } catch (error) {
        console.log(error);
        alert("Action failed!")
    } finally {
        processing.value = false
    }
}

onMounted(fetchTellers)
</script>

<template>
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold mb-0">Vault to Teller Cash Load</h4>
                <p class="text-muted small">Distribute cash from main vault to teller counters</p>
            </div>
            <button @click="fetchTellers" class="btn btn-white shadow-sm rounded-pill px-3">
                <i class="fas fa-sync-alt me-2"></i> Refresh
            </button>
        </div>

        <div class="row g-4" v-if="!loading">
            <div v-for="teller in tellers" :key="teller.id" class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 teller-card">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="avatar bg-primary-subtle text-primary rounded-circle me-3">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">{{ teller?.teller_name }}</h6>
                                <small class="text-muted">ID: #{{ teller?.teller_id }} | Branch: {{ teller?.branch_name
                                    }}</small>
                            </div>
                        </div>

                        <div class="bg-light rounded-3 p-3 mb-4">
                            <small class="text-muted d-block mb-1">Current Cash in Hand</small>
                            <h4 class="fw-bold mb-0 text-dark">BDT {{ teller.current_balance?.toLocaleString() }}</h4>
                        </div>

                        <button @click="openLoadModal(teller.teller_id)" class="btn btn-primary w-100 rounded-pill fw-bold">
                            <i class="fas fa-plus-circle me-2"></i> Load Cash
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showModal" class="custom-modal-overlay">
            <div class="custom-modal-card shadow-lg rounded-4 animate__animated animate__zoomIn">
                <div class="modal-header-ui p-4 bg-primary text-white rounded-top-4">
                    <h5 class="mb-0 fw-bold">Load Cash to Teller</h5>
                    <button @click="showModal = false" class="btn-close btn-close-white"></button>
                </div>
                <div class="p-4 bg-white">
                    <div class="mb-4 text-center">
                        <small class="text-muted">Target Teller</small>
                        <h5 class="fw-bold text-primary">{{ selectedTeller?.teller_name }}</h5>
                    </div>

                    <div class="form-group mb-4">
                        <label class="form-label fw-bold">Amount to Load (BDT)</label>
                        <input v-model="loadAmount" type="number"
                            class="form-control form-control-lg text-center fw-bold border-2 border-primary-subtle"
                            placeholder="0.00">
                        <div class="mt-2 d-flex justify-content-between">
                            <button @click="loadAmount = 50000" class="btn btn-sm btn-outline-secondary">50k</button>
                            <button @click="loadAmount = 100000" class="btn btn-sm btn-outline-secondary">100k</button>
                            <button @click="loadAmount = 500000" class="btn btn-sm btn-outline-secondary">500k</button>
                        </div>
                    </div>

                    <button @click="submitCashLoad" :disabled="processing"
                        class="btn btn-primary btn-lg w-100 rounded-pill">
                        <span v-if="processing" class="spinner-border spinner-border-sm me-2"></span>
                        Confirm Loading
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.avatar {
    width: 45px;
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.teller-card {
    transition: transform 0.2s;
}

.teller-card:hover {
    transform: translateY(-5px);
}

/* Custom Modal Styles */
.custom-modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1050;
}

.custom-modal-card {
    width: 400px;
    overflow: hidden;
}

.btn-white {
    background: white;
    border: 1px solid #dee2e6;
}
</style>