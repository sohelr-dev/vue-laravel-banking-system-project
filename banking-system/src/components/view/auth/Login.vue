<script setup lang="ts">
import { defaultUser, type UserType } from '@/components/interfaces/users.interfaces';
import api from '@/config/config';
import { useAuthStore } from '@/store/auth';
import { onMounted, reactive } from 'vue';
import { useRouter } from 'vue-router';


  const form = reactive<UserType>(defaultUser);
  const router =useRouter();
  const auth =useAuthStore();
  // console.log(auth.token);

  function handleLogin(){
    api.post('/login',form)
    .then((response)=>{
      if(response.data.success ===true){
        auth.setAuth({
          user: response.data.user,
          token: response.data.token,
        });
        router.replace('/dashboard');
        alert('login successful');
      }else{
        alert('Login failed.');
      }
    })
    .catch((error)=>{
      console.error(error);
      alert('login failed .Please check your credentials');
    })

  }
  onMounted(()=>{
    document.title="Login"
  });

</script>
<template>
  <div class="container d-flex justify-content-center align-items-center min-vh-100">

    
    <div class="card shadow p-4 login-card">
      
      <h3 class="text-center mb-2">Login</h3>
      <hr>
      <div class="card mb-3 p-3 shadow-sm">
        <div class="d-flex flex-wrap justify-content-center gap-2">
          <button class="btn btn-outline-primary rounded" @click="form.email = 'admin@gmail.com'">
            Admin
          </button>
          <button class="btn btn-outline-secondary rounded" @click="form.email = 'rupon@gmail.com'">
            Teller/Cashier
          </button>
          <button class="btn btn-outline-warning rounded" @click="form.email = 'habibur@gmail.com'">
            Customer
          </button>
          <button class="btn btn-outline-danger rounded" @click="form.email = 'mahedi@gmail.com'">
            Customer2
          </button>
          <button class="btn btn-outline-success rounded" @click="form.password = '123123123'">
            Password
          </button>
        </div>
      </div>

      <form @submit.prevent="handleLogin">

        <div class="mb-3">
          <label>Email</label>
          <input
            type="email"
            v-model="form.email"
            class="form-control"
            placeholder="Enter your email"
            required
          />
        </div>

        <div class="mb-3">
          <label>Password</label>
          <input
            type="password"
            v-model="form.password"
            class="form-control"
            placeholder="Enter your password"
            required
          />
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
      </form>
      <div class="text-center mt-3">
        <span class="text-muted">Don't have an account?</span>
        <br />
        <span class="fw-semibold text-primary">Please contact any branch.</span>
    </div>
    </div>
  </div>
</template>

<style scoped>
.login-card {
  max-width: 400px;
  width: 100%;
  border-radius: 12px;
}

@media (max-width: 576px) {
  .login-card {
    padding: 20px;
  }
}
</style>
