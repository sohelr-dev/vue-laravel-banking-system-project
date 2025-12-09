<template>
  <!-- Overlay for mobile -->
  <div v-if="isMobile && isOpen" class="overlay" @click="closeSidebar"></div>

  <aside :class="['sidebar', { open: isOpen, collapsed: isCollapsed }]">
    <div class="sidebar-header">
      <h2 v-if="!isCollapsed">Banking</h2>
      <button v-if="isMobile" class="close-btn" @click="closeSidebar">
        <i class="fas fa-times"></i>
      </button>
    </div>

    <ul class="menu">
      <li
        v-for="item in menu"
        :key="item.name"
        :class="{ active: active === item.name }"
        @click="setActive(item.name)"
      >
        <i :class="item.icon"></i>
        <span v-if="!isCollapsed">{{ item.name }}</span>
      </li>
    </ul>
  </aside>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

const isOpen = ref(true);         // Sidebar visible initially on desktop
const isCollapsed = ref(false);   // Not collapsed initially
const isMobile = ref(false);
const active = ref('Dashboard');

const menu = [
  { name: 'Dashboard', icon: 'fas fa-home' },
  { name: 'Customers', icon: 'fas fa-users' },
  { name: 'Transactions', icon: 'fas fa-money-bill' },
  { name: 'Reports', icon: 'fas fa-chart-line' },
];

const checkScreen = () => {
  isMobile.value = window.innerWidth <= 768;

  if (isMobile.value) {
    isCollapsed.value = false; // full width on mobile
    isOpen.value = false;      // hidden by default
  } else {
    isCollapsed.value = false; // full sidebar desktop
    isOpen.value = true;
  }
};

const toggleSidebar = () => {
  if (!isMobile.value) {
    // Desktop: collapse/expand
    isCollapsed.value = !isCollapsed.value;
  } else {
    // Mobile: toggle open/close
    isOpen.value = !isOpen.value;
  }
};

const closeSidebar = () => {
  isOpen.value = false;
};

const setActive = (name: string) => {
  active.value = name;
};

onMounted(() => {
  checkScreen();
  window.addEventListener("resize", checkScreen);
});

onUnmounted(() => {
  window.removeEventListener("resize", checkScreen);
});

defineExpose({ toggleSidebar });
</script>

<style scoped>
.sidebar {
  position: fixed;
  left: 0;
  top: 0;
  height: 100vh;
  background: #0a1a2f;
  color: #fff;
  padding: 20px;
  transition: width 0.3s ease, transform 0.3s ease;
  z-index: 2000;
  overflow: hidden;
  width: 240px; /* full width */
}

/* Collapsed sidebar (desktop toggle) */
.sidebar.collapsed {
  width: 70px;
}

/* Mobile hidden */
.sidebar:not(.open) {
  transform: translateX(-100%);
}

/* Smooth in-out */
.sidebar.open {
  transform: translateX(0);
}

.sidebar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.menu {
  margin-top: 30px;
  list-style: none;
  padding: 0;
}

.menu li {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 12px 5px;
  cursor: pointer;
  border-radius: 6px;
  transition: 0.3s;
}

.menu li.active {
  border-left: 4px solid #007bff;
  background: #112a45;
}

.menu li:hover {
  background: #112a45;
}

.overlay {
  position: fixed;
  width: 100%;
  height: 100%;
  background: #00000080;
  top: 0;
  left: 0;
  z-index: 1500;
}

.close-btn {
  background: none;
  border: none;
  color: white;
  font-size: 20px;
}
</style>
