<script setup lang="ts">
import { useAuthStore } from '@/store/auth';
  const auth =useAuthStore();

  function handleLogOut(){
    auth.logout();
  }


</script>
<template>
  <nav class="navbar topbar-bg bg-opacity-10 p-2">
    <div class="container-fluid d-flex align-items-center flex-nowrap">
      <!-- Mobile Toggle -->
      <label for="sidebar-toggle" class="cursor-pointer d-lg-none me-2">
          <i class="fa-solid fa-bars-staggered fa-fade fa-lg"></i>
      </label>

      <!-- Search Bar -->
      <div class=" me-3">
        <form class="d-flex" role="search" action="#" method="GET">
             <input class="form-control form-control-md me-2" type="search" name="q"
                  placeholder="Search" aria-label="Search">
             <button class="btn btn-sm btn-outline-light" type="submit">Search</button>
        </form>
      </div>

      <!-- Right Options -->
      <div class="top-right d-flex align-items-center gap-4 ms-auto">

        <!-- Notification -->
        <div class="position-relative cursor-pointer">
          <i class="fa-solid fa-bell fa-lg"></i>
          <span class="badge bg-danger notify-badge">3</span>
        </div>

        <!-- Theme Toggle -->
        <button id="theme-toggle" class="btn btn-outline-light ms-2 me-3 btn-sm ">
          <i class="fa-solid fa-moon"></i>
        </button>

        <!-- Profile Dropdown -->
        <div class="dropdown">
          <a class="d-flex align-items-center gap-2 dropdown-toggle" data-bs-toggle="dropdown">
            <img src="/assets/img/custom_icon/man1.png" class="rounded-circle" width="36" height="36" />
            <span class="fw-semibold d-none d-sm-inline text-light">{{ auth.user?.name || 'Admin/Cashier'}}</span>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="#">My Profile</a></li>
            <li><a class="dropdown-item" href="#">Settings</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li><button type="submit" class="dropdown-item" @click="handleLogOut">
              <i class="fa fa-sign-out-alt me-2 text-dark-emphasis"></i>
              Logout</button></li>
          </ul>
        </div>

      </div>

    </div>
  </nav>
</template>



<style scoped>
.topbar {
  height: 60px;
  background: #121826;
  color: #fff;
  display: flex;
  align-items: center;
  border-bottom: 1px solid rgba(255,255,255,0.1);
}
.topbar-bg {
  background-color: #34495E !important;
  color: #FFFFFF !important;
}
.toggle-btn i {
  color: #fff;
  font-size: 22px;
  cursor: pointer;
}
.top-search input {
  background: #1e2533;
  border: 1px solid #2a3142;
  color: #fff;
}
.top-right i {
  color: #fff;
  cursor: pointer;
}
.notify-badge {
  position: absolute;
  top: -5px;
  right: -6px;
  font-size: 10px;
  padding: 3px 5px;
}
.theme-btn i { color: #fff; }
</style>