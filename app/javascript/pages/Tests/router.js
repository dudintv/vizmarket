import Vue from 'vue'
import VueRouter from 'vue-router'

const TestColors = () => import('./Colors')
const TestInputs = () => import('./Inputs')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/test/colors', component: TestColors },
    { path: '/test/inputs', component: TestInputs },
  ],
})
