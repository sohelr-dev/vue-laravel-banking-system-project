<template>
  <div class="app-layout d-flex">
    <SidebarVue />
    <div class="main w-100">
      <TopbarVue />
      <div class="content">
        <router-view/>
      </div>
    </div>
  </div>
</template>

<script setup>
import SidebarVue from './Sidebar.vue';
import TopbarVue from './Topbar.vue';
</script>

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