import Vue from 'vue'
import VueRouter from 'vue-router'

const SettingsGeneral = () => import('../General')
const SettingsPassword = () => import('../Password')
const SettingsPublisher = () => import('../Publisher')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/settings', redirect: '/settings/user/general' },
    { path: '/settings/user/general', component: SettingsGeneral },
    // { path: '/settings/payments', component: undefined },
    // { path: '/settings/history', component: undefined },
    { path: '/settings/user/password', component: SettingsPassword },
    // { path: '/settings/agreements', component: undefined },
    // { path: '/settings/linked_accounts', component: undefined },
    { path: '/settings/user/publisher', component: SettingsPublisher },
    // { path: '/settings/help', component: undefined },
  ]
})
