import { createRouter, createWebHistory } from "vue-router";
import Dashboard from "../view/pages/admin/Dashboard.vue";
import UsersList from "../view/pages/Users/UsersList.vue";
import UsersDetails from "../view/pages/Users/UsersDetails.vue";
import Login from "../view/auth/Login.vue";
import { useAuthStore } from "@/store/auth";
import Registration from "../view/auth/Registration.vue";
import DefaultLayout from "../view/layouts/DefaultLayout.vue";
import CustomerTopbar from "../view/layouts/CustomerTopbar.vue";
import TellerDashboard from "../view/pages/teller/TellerDashboard.vue";
import TellerManage from "../view/pages/admin/users/tellers/TellerManage.vue";
import TellerDetails from "../view/pages/admin/users/tellers/TellerDetails.vue";
import TellerCreate from "../view/pages/admin/users/tellers/TellerCreate.vue";
import CustomerManage from "../view/pages/admin/users/customers/CustomerManage.vue";
import CustomerDetails from "../view/pages/admin/users/customers/CustomerDetails.vue";
import CustomerRegister from "../view/pages/admin/users/customers/CustomerRegister.vue";
import Deposit from "../view/pages/teller/transactions/Deposit.vue";

const routes = [
  { path: '/login', component: Login, meta: { guestOnly: true } },
  { path: '/register', component: Registration, meta: { guestOnly: true } },

  { 
    path: '/', component: DefaultLayout,
    children: [
      {path: '', redirect: '/dashboard'},
      { path: 'dashboard', component: Dashboard, meta: { requiresAuth: true, role: 1 } },
      { path: 'users', component: UsersList, meta: { requiresAuth: true, role: 1 } },
      { path: 'users/user-details/:id', component: UsersDetails, meta: { requiresAuth: true, role: 1 } },
      
      //teller
      { path: 'tellers', component: TellerManage, meta: { requiresAuth: true, role: 1 } },
      { path: 'tellers/details/:id', component: TellerDetails, meta: { requiresAuth: true, role: 1 } },
      { path: 'tellers/add', component: TellerCreate, meta: { requiresAuth: true, role: 1 } },
      //customer
      { path: 'customers', component: CustomerManage, meta: { requiresAuth: true, role: 1 } },
      { path: 'customers/:id/details', component: CustomerDetails, meta: { requiresAuth: true, role: 1 } },
      { path: 'customers/add', component: CustomerRegister, meta: { requiresAuth: true, role: 1 } },

    ]
  },
  {
    path:'/teller', component: DefaultLayout,
    children: [
      { path: 'dashboard', component: TellerDashboard, meta: { requiresAuth: true, role: 2 } },
      { path: '/customer-accounts', component: CustomerManage, meta: { requiresAuth: true, role: 2 } },
      { path: '/customer-accounts/add', component: CustomerRegister, meta: { requiresAuth: true, role: 2 } },
      { path: '/customer-accounts/:id/details', component: CustomerDetails, meta: { requiresAuth: true, role: 2 } },
      //deposit
      { path: '/teller/deposit', component: Deposit, meta: { requiresAuth: true, role: 2 } },
    ]
  },
  {
    path:'/customer', component: CustomerTopbar,
    children: [
      { path: 'dashboard', component: TellerDashboard, meta: { requiresAuth: true, role: 3 } },
      { path: 'user', component: TellerDashboard, meta: { requiresAuth: true, role: 3 } },
    ]
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const auth = useAuthStore();

  if (to.meta.requiresAuth) {
    if (!auth.isauthenticated) return next('/login');

    if (to.meta.role && auth.user?.role_id !== to.meta.role) {
      // redirect to own dashboard
      switch(auth.user?.role_id) {
        case 1: return next('/dashboard'); // admin
        case 2: return next('/teller/dashboard');
        case 3: return next('/customer/dashboard');
      }
    }
  }

  // guest only
  if (to.meta.guestOnly && auth.isauthenticated) {
    // logged in user -> redirect
    switch(auth.userRole) {
      case 1: return next('/dashboard');
      case 2: return next('/teller/dashboard');
      case 3: return next('/customer/dashboard');
    }
  }

  next()
})

export default router;