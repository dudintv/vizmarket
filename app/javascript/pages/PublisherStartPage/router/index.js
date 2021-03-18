import Vue from 'vue'
import VueRouter from 'vue-router'

const PublicTab = () => import('../PublicTab')
const PrivateTab = () => import('../PrivateTab')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/publisher/author/start', redirect: '/publisher/author/start/public' },
    { path: '/publisher/author/start/public', component: PublicTab },
    { path: '/publisher/author/start/private', component: PrivateTab },
  ]
})
