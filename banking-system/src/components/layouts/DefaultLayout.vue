<template>
  <div class="layout">
    <Sidebar ref="sidebarRef" />

    <div class="main">
      <Topbar @toggleSidebar="toggleSidebar" />
      <div class="content">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import Sidebar from "./Sidebar.vue";
import Topbar from "./Topbar.vue";
import { ref } from "vue";

const sidebarRef = ref();

const toggleSidebar = () => {
  sidebarRef.value.toggleSidebar();
};
</script>

<style scoped>
.layout {
  display: flex;
}

.main {
  flex: 1;
}

.content {
  padding: 20px;
  min-height: 100vh;
  background: #f5f7fa;
}
</style>
