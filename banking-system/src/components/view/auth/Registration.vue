<script setup lang="ts">

import { defaultUser, type UserType } from '@/components/interfaces/users.interfaces';
import api from '@/config/config';
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';


    const form= reactive<UserType>(defaultUser);
    const nagivate =useRouter();
    // const errors=ref<({});
    // console.log(errors);

    function handleSubmit(){
        // console.log(form);
        api.post('/register',form)
        .then((response)=>{
            // console.log(response.data);
            if(response.data.success === true){
                alert('Registration Successfull');
                nagivate.push('/login');
            }
        })
        .catch((error)=>{
            console.error(error.response.data.errors);
            // errors.valueOf = error.response.data.errors;
        })

    }

</script>
 <template>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card bg-white shadow-sm p-5 rounded-3">
                    <h3 class="text-center mb-4">Registration</h3>

                    <form @submit.prevent="handleSubmit" enctype="multipart/form-data" novalidate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name *</label>
                                <input v-model="form.name" type="text" class="form-control" name="name" />
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email *</label>
                                <input v-model="form.email" type="email" class="form-control" name="email" />
                            </div>
                        </div>

                        

                        <!-- <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Branch</label>
                                <input v-model="form.branch" type="text" class="form-control" name="branch" />
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phone</label>
                                <input v-model="form.phone" type="text" class="form-control" name="phone" />
                            </div>
                        </div> -->

                        <!-- <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">NID / National ID</label>
                                <input v-model="form.nid" type="text" class="form-control" name="nid" />
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Profile Photo</label>
                                <input type="file" class="form-control"
                                    accept="image/*" />
                            </div>
                        </div> -->

                        <!-- <div class="row align-items-center">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Access Level</label>
                                <select v-model="form.access_level" class="form-select" name="access_level">
                                    <option value="1">Admin</option>
                                    <option value="2">Cashier</option>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3 d-flex align-items-center">
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" v-model="form.two_factor"
                                        id="two_factor" />
                                    <label class="form-check-label ms-2" for="two_factor">Enable 2FA</label>
                                </div>
                            </div>
                        </div> -->

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Password *</label>
                                <input v-model="form.password" type="password" class="form-control" name="password" />
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Confirm Password *</label>
                                <input v-model="form.password_confirmation" type="password" class="form-control"
                                    name="confirmPassword" />
                            </div>
                        </div>

                        <button  type="submit" class="btn btn-primary w-100 py-2">Create Admin Account</button>

                        <div class="text-center mt-3">
                            Already registered? <router-link to="/login">Login</router-link>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
 </template>