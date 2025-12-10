<script setup lang="ts">
import Sidebar from "./Sidebar.vue";
import Topbar from "./Topbar.vue";
import "@/assets/custom.css";
</script>

<template>
  <div class="d-flex">
    <Sidebar />
    <div class="main w-100">
      <Topbar />
      <div class="container mt-4">
        <RouterView />
      </div>
    </div>
  </div>
</template>
