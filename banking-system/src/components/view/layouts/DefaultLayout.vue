<script setup lang="ts">
import { computed } from 'vue';
import SidebarVue from './Sidebar.vue';
import TopbarVue from './Topbar.vue';
import { useAuthStore } from '@/store/auth';

  const auth =useAuthStore();
  const isAuth= computed(()=>auth.isauthenticated);

</script>
<template>
  <div class="app-layout d-flex" v-if="isAuth">
    <SidebarVue />
    <div class="main w-100">
      <TopbarVue />
      <div class="content">
        <router-view/>
      </div>
    </div>
  </div>
  <div v-else>
    <router-view />

  </div>
</template>


<style scoped>
.main{
     margin-left: 280px;
}
@media screen and (max-width: 768px) {
     .main{
          margin-left: 0px;
     }

}
@media(max-width: 1024px){
    .main {
        margin-left: 0 !important;
    }
}
</style>