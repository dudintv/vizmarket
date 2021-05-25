import Vue from 'vue'
import VueRouter from 'vue-router'

const UsersList = () => import('../UsersList')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/admin', redirect: '/admin/users' },
    { path: '/admin/users', component: UsersList, name: 'UsersList' },
  ]
})
