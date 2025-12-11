<template>
  <div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="card shadow p-4 login-card">

      <h3 class="text-center mb-4">Login</h3>

      <form @submit.prevent="login">

        <div class="mb-3">
          <label>Email</label>
          <input
            type="email"
            v-model="email"
            class="form-control"
            placeholder="Enter your email"
            required
          />
        </div>

        <div class="mb-3">
          <label>Password</label>
          <input
            type="password"
            v-model="password"
            class="form-control"
            placeholder="Enter your password"
            required
          />
        </div>

        <button class="btn btn-primary w-100" :disabled="loading">
          <span v-if="loading" class="spinner-border spinner-border-sm"></span>
          <span v-else>Login</span>
        </button>

      </form>

    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      loading: false,
    };
  },

  methods: {
    async login() {
      this.loading = true;

      // Example request — change API URL
      try {
        const res = await fetch("http://localhost:8000/api/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            email: this.email,
            password: this.password,
          }),
        });

        const data = await res.json();
        this.loading = false;

        if (res.status === 200) {
          alert("Login Successful");
          // store token
          localStorage.setItem("token", data.token);

          this.$router.push("/dashboard");
        } else {
          alert(data.message || "Login failed");
        }
      } catch (err) {
        this.loading = false;
        alert("Network error!");
      }
    },
  },
};
</script>

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
