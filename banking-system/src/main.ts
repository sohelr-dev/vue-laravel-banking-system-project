import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap'
import "@fortawesome/fontawesome-free/css/all.min.css"

import { createApp } from 'vue'
import App from './App.vue'
import myRoutes from './components/routes'
import { createPinia } from 'pinia'

const pinia =createPinia();


createApp(App)
.use(myRoutes)
.use(pinia)
.mount('#app')
