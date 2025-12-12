<script setup lang="ts">
import { useAuthStore } from '@/store/auth';

    const title ='Dashboard';
    const auth =useAuthStore();
    console.log(auth.user?.name);

</script>
<template>
    <div class="container">
        <h1 class="text-dark">Wellcome to  {{ auth.user?.role_id ===1 ?"Admin"
                                                : auth.user?.role_id === 2?'Cashier'
                                                :auth.user?.role_id === 3 ?'Customer': ''}} Dashboard</h1>

    </div>
</template>


<style  scoped>

</style>