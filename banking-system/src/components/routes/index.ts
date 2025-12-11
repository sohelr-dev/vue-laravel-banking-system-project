import { createRouter, createWebHistory } from "vue-router";
import Dashboard from "../view/pages/Dashboard.vue";
import UsersList from "../view/pages/Users/UsersList.vue";
import UsersDetails from "../view/pages/Users/UsersDetails.vue";
import Login from "../view/auth/Login.vue";
import App from "@/App.vue";
import DefaultLayout from "../view/layouts/DefaultLayout.vue";


const myRoutes =createRouter({
    history:createWebHistory(),
    routes:[
        {path:'/', redirect:'/dashboard',
            children:[
                {path:'dashboard',component:Dashboard},
                {path:'users',component:UsersList},
                {path:'users/user-details/:id',component:UsersDetails},
            ]
        },
        {path:'/login',component:Login},
    ], 
    
    
})
export default myRoutes;