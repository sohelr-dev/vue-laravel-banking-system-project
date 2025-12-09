<template>
  <nav class="topbar">
    <button class="menu-btn" @click="$emit('toggleSidebar')">
      <i class="fas fa-bars"></i>
    </button>

    <div class="right-section">
      <div class="icon">
        <i class="fas fa-bell"></i>
      </div>

      <div class="icon">
        <i class="fas fa-envelope"></i>
      </div>

      <!-- Customer Dropdown -->
      <div class="profile" @click="toggleDropdown">
        <img src="https://i.pravatar.cc/40" />
        <div v-if="dropdownOpen" class="dropdown">
          <p>Profile</p>
          <p>Settings</p>
          <p>Logout</p>
        </div>
      </div>
    </div>
  </nav>
</template>

<script setup lang="ts">
import { ref } from "vue";
const dropdownOpen = ref(false);

const toggleDropdown = () => {
  dropdownOpen.value = !dropdownOpen.value;
};
</script>

<style scoped>
.topbar {
  height: 60px;
  background: #f5f5f1;
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid #eee;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.menu-btn {
  font-size: 20px;
  background: none;
  border: none;
  cursor: pointer;
}

.right-section {
  display: flex;
  align-items: center;
  gap: 20px;
}

.icon {
  font-size: 18px;
  cursor: pointer;
}

.profile {
  position: relative;
  cursor: pointer;
}

.profile img {
  width: 38px;
  border-radius: 50%;
}

.dropdown {
  position: absolute;
  right: 0;
  top: 50px;
  background: white;
  padding: 10px 15px;
  box-shadow: 0 3px 10px #0002;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.dropdown p {
  margin: 0;
  padding: 8px 0;
  cursor: pointer;
}

.dropdown p:hover {
  color: #007bff;
}
</style>
