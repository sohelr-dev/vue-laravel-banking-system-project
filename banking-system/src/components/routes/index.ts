import { createRouter, createWebHistory } from "vue-router";
import Dashboard from "../view/pages/Dashboard.vue";
import UsersList from "../view/pages/Users/UsersList.vue";
import UsersDetails from "../view/pages/Users/UsersDetails.vue";


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
    ]
})
export default myRoutes;