<template>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-lg border-0 rounded-lg">

                    <div class="card-header bg-navy text-white p-4">
                        <h4 class="mb-1 text-center font-weight-bold">Open New Bank Account</h4>
                        <p class="text-center mb-4 small opacity-75">Follow the steps to register a new customer</p>

                        <div class="stepper-wrapper d-flex justify-content-between">
                            <div
                                :class="['stepper-item', currentStep >= 1 ? 'active' : '', currentStep > 1 ? 'completed' : '']">
                                <div class="step-counter">1</div>
                                <div class="step-name">Account</div>
                            </div>
                            <div
                                :class="['stepper-item', currentStep >= 2 ? 'active' : '', currentStep > 2 ? 'completed' : '']">
                                <div class="step-counter">2</div>
                                <div class="step-name">Profile</div>
                            </div>
                            <div
                                :class="['stepper-item', currentStep >= 3 ? 'active' : '', currentStep > 3 ? 'completed' : '']">
                                <div class="step-counter">3</div>
                                <div class="step-name">Banking</div>
                            </div>
                        </div>
                    </div>

                    <div class="card-body p-4 p-md-5">
                        <form @submit.prevent="submitRegistration">

                            <div v-if="currentStep === 1" class="step-content animate-fade-in">
                                <h5 class="mb-4 text-primary fw-bold"><i class="fas fa-user-circle me-2"></i>User
                                    Credentials</h5>
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">Full Name</label>
                                        <input v-model="form.name" type="text" class="form-control px-3 py-2"
                                            placeholder="John Doe">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Email Address</label>
                                        <input v-model="form.email" type="email" class="form-control px-3 py-2"
                                            placeholder="email@bank.com">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Phone Number</label>
                                        <input v-model="form.phone" type="text" class="form-control px-3 py-2"
                                            placeholder="017XXXXXXXX">
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">Password</label>
                                        <input v-model="form.password" type="password" class="form-control px-3 py-2"
                                            placeholder="********">
                                    </div>
                                </div>
                            </div>

                            <div v-if="currentStep === 2" class="step-content animate-fade-in">
                                <h5 class="mb-4 text-primary fw-bold"><i class="fas fa-map-marker-alt me-2"></i>Personal
                                    Details</h5>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Date of Birth</label>
                                        <input v-model="form.dob" type="date" class="form-control px-3 py-2">
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">Full Address</label>
                                        <textarea v-model="form.address" class="form-control px-3 py-2" rows="3"
                                            placeholder="Street, City, Country"></textarea>
                                    </div>
                                </div>
                            </div>

                            <div v-if="currentStep === 3" class="step-content animate-fade-in">
                                <h5 class="mb-4 text-primary fw-bold"><i class="fas fa-university me-2"></i>Account
                                    Selection</h5>
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">Select Branch</label>
                                        <select v-model="form.branch_id" class="form-select px-3 py-2">
                                            <option value="0">Select a branch</option>
                                            <option v-for="branch in branches" :key="branch.id" :value="branch.id">{{
                                                branch.name }}</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">Account Type</label>
                                        <div class="row g-2">
                                            <div v-for="type in accountTypes" :key="type.id" class="col-md-6">
                                                <input type="radio" class="btn-check" name="accType"
                                                    :id="'type' + type.id" :value="type.id"
                                                    v-model="form.account_type_id">
                                                <label class="btn btn-outline-primary w-100 py-3 text-start"
                                                    :for="'type' + type.id">
                                                    <div class="fw-bold">{{ type.type_name }}</div>
                                                    <small class="opacity-75">Interest: {{ type.interest_rate
                                                        }}%</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between mt-5 pt-4 border-top">
                                <button v-if="currentStep > 1" type="button" @click="currentStep--"
                                    class="btn btn-light px-4 py-2 border">
                                    <i class="fas fa-chevron-left me-2"></i> Back
                                </button>
                                <div v-else></div>

                                <button v-if="currentStep < 3" type="button" @click="currentStep++"
                                    class="btn btn-primary px-5 py-2">
                                    Next Step <i class="fas fa-chevron-right ms-2"></i>
                                </button>
                                <button v-else type="submit" class="btn btn-success px-5 py-2" :disabled="loading">
                                    <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                                    <i v-else class="fas fa-check-circle me-2"></i> Confirm Registration
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import api from '@/config/config';
import { useRouter } from 'vue-router';

const router = useRouter();
const currentStep = ref(1);
const loading = ref(false);

const form = ref({
    name: '', email: '', phone: '', password: '',
    dob: '', address: '',
    branch_id: 0, account_type_id: 0
});

const branches = ref<any[]>([]);
const accountTypes = ref<any[]>([]);

onMounted(async () => {
    // Fetch branches and account types for dropdowns
    const branchRes = await api.get('branches');
    branches.value = branchRes.data.branches;

    const typeRes = await api.get('account-types');
    accountTypes.value = typeRes.data.types;
});

const submitRegistration = async () => {
    loading.value = true;
    try {
        await api.post('customers/register', form.value);
        alert("Registration Successful!");
        router.push('/customers');
    } catch (error) {
        console.error(error);
        alert("Error occurred during registration.");
    } finally {
        loading.value = false;
    }
};
</script>

<style scoped>
.bg-navy {
    background-color: #1a237e;
}

.text-primary {
    color: #1a237e !important;
}

.btn-primary {
    background-color: #1a237e;
    border-color: #1a237e;
}

/* Stepper CSS */
.stepper-wrapper {
    position: relative;
    margin-bottom: 20px;
}

.stepper-item {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    flex: 1;
    z-index: 2;
}

.stepper-item::before {
    position: absolute;
    content: "";
    border-bottom: 2px solid #ccc;
    width: 100%;
    top: 18px;
    left: -50%;
    z-index: 1;
}

.stepper-item:first-child::before {
    content: none;
}

.step-counter {
    position: relative;
    z-index: 5;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: #ccc;
    margin-bottom: 6px;
    font-weight: bold;
    color: white;
}

.active .step-counter {
    background-color: #ffd600;
    color: #1a237e;
}

.completed .step-counter {
    background-color: #4caf50;
}

.step-name {
    font-size: 0.8rem;
    font-weight: 500;
    opacity: 0.8;
}

/* Animations */
.animate-fade-in {
    animation: fadeIn 0.4s ease-in-out;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>