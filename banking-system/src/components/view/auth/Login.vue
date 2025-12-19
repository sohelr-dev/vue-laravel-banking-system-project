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

      <h3 class="text-center mb-4">Login</h3>

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
        Don't have an account? <router-link to="/register">Register</router-link>
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
