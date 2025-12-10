import { createRouter, createWebHistory } from "vue-router";
import Dashboard from "../view/pages/Dashboard.vue";


const myRoutes =createRouter({
    history:createWebHistory(),
    routes:[
        {path:'/', redirect:'/dashboard',
            children:[
                {path:'dashboard',component:Dashboard},
            ]
        },
    ]
})
export default myRoutes;