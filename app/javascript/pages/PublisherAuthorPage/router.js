import Vue from 'vue'
import VueRouter from 'vue-router'

// const SettingsGeneral = () => import('../General')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    // { path: '/settings/help', component: undefined },
  ]
})
