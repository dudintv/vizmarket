import Vue from 'vue'
import VueRouter from 'vue-router'

const SettingsGeneral = () => import('./General')
const SettingsPassword = () => import('./Password')
const SettingsLinkedAccounts = () => import('./LinkedAccounts')
const SettingsInvitations = () => import('./MyInvitations')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/settings', redirect: '/settings/user/general' },
    { path: '/settings/user/general', component: SettingsGeneral },
    { path: '/settings/user/password', component: SettingsPassword },
    { path: '/settings/user/linked_accounts', component: SettingsLinkedAccounts },
    { path: '/settings/user/invitations', component: SettingsInvitations },
    // { path: '/settings/user/payments', component: undefined },
    // { path: '/settings/user/history', component: undefined },
    // { path: '/settings/user/publisher', component: undefined },
    // { path: '/settings/agreements', component: undefined },
    // { path: '/settings/help', component: undefined },
  ]
})
