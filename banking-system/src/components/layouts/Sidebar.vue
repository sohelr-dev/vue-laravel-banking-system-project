<script setup lang="ts">
import { useAuthStore } from "@/store/auth";
import { computed } from "vue";

const auth = useAuthStore();

const user = computed(() => auth.user);
const token = computed(() => auth.token);
const role = computed(() => auth.user?.role_id);
// const role = 1;
const logout = () => auth.logout();
</script>

<template>
  <input type="checkbox" id="sidebar-toggle" class="d-none" />
  <label for="sidebar-toggle" class="bg-layer"></label>

  <div id="sidebar">
    <span class="fs-2 d-lg-none" id="close-btn">
      <label for="sidebar-toggle">
        <i class="fas fa-chevron-left text-light"></i>
      </label>
    </span>

    <!-- Roles -->
    <h4 v-if="role === 1" class="text-center">Admin Panel</h4>
    <h4 v-else-if="role === 2" class="text-center">Vendor Panel</h4>
    <h4 v-else-if="role === 4" class="text-center">Delivery Staff Panel</h4>
    <h4 v-else class="text-danger text-center">You are not authorized</h4>

    <!-- Profile -->
    <div class="text-center mb-4">
      <img
        v-if="user?.photo"
        :src="user?.photo"
        class="rounded-circle"
        width="80"
        height="80"
      />
      <img
        v-else
        src="@/assets/img/sohel.jpg"
        class="rounded-circle"
        width="80"
        height="80"
      />

      <h5 v-if="role" class="mt-2 mb-0">{{ user?.name }}</h5>
      <small v-if="role === 1" class="text-light">Administrator</small>
      <small v-if="role === 2" class="text-light">Seller</small>
      <small v-if="role === 4" class="text-light">Courier</small>
      <small v-if="!role" class="text-danger">Unauthorized</small>
    </div>

    <!-- Menu -->
    <nav class="navbar sidebar-menu">
      <ul class="nav flex-column">

        <!-- Dashboard -->
        <li class="nav-item">
          <RouterLink to="/dashboard" class="nav-link text-light">
            <i class="fa-solid fa-grip me-2 fa-lg"></i> Dashboard
          </RouterLink>
        </li>

        <!-- User Manage (Admin Only) -->
        <li v-if="role === 1">
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#usersMenu">
            <i class="fas fa-users me-2 fa-lg"></i> User Manage
          </a>
          <div class="collapse" id="usersMenu">
            <ul class="list-unstyled ps-4">
              <li><RouterLink to="/users" class="nav-link text-white"><i class="fas fa-user me-2"></i> All Users</RouterLink></li>
              <li><RouterLink to="/vendors" class="nav-link text-white"><i class="fas fa-store me-2"></i> Vendors</RouterLink></li>
              <li><RouterLink to="/vendor-requests" class="nav-link text-white"><i class="fas fa-user-clock me-2"></i> Vendor Requests</RouterLink></li>
              <li><RouterLink to="/delivery-staff" class="nav-link text-white"><i class="fas fa-truck me-2"></i> Delivery Staff</RouterLink></li>
            </ul>
          </div>
        </li>

        <!-- Products (Admin+Vendor) -->
        <li v-if="role === 1 || role === 2">
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#productsMenu">
            <i class="fas fa-boxes-stacked me-2 fa-lg"></i> Products
          </a>
          <div class="collapse" id="productsMenu">
            <ul class="list-unstyled ps-4">
              <li><RouterLink to="/products" class="nav-link text-white"><i class="fas fa-box me-2"></i> All Products</RouterLink></li>
              <li><RouterLink to="/products/create" class="nav-link text-white"><i class="fas fa-plus me-2"></i> Add Product</RouterLink></li>
              <li><RouterLink to="/categories" class="nav-link text-white"><i class="fas fa-tags me-2"></i> Categories</RouterLink></li>
              <li><RouterLink to="/brands" class="nav-link text-white"><i class="fas fa-copyright me-2"></i> Brands</RouterLink></li>
            </ul>
          </div>
        </li>

        <!-- Profile -->
        <li v-if="role">
          <RouterLink to="/profile" class="nav-link text-light">
            <i class="fas fa-user-circle me-2 fa-lg"></i> Profile
          </RouterLink>
        </li>

        <!-- Logout -->
        <li v-if="role">
          <button @click="logout" class="nav-link text-light border-0 bg-transparent">
            <i class="fas fa-sign-out-alt me-2 fa-lg"></i> Logout
          </button>
        </li>
      </ul>
    </nav>
  </div>
</template>

<style scoped src="./sidebar.css"></style>