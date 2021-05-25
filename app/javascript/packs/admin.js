import Vue from 'vue'
import store from '../pages/AdminPage/store'
import router from '../pages/AdminPage/router'
// import Vuelidate from 'vuelidate'
import AdminPage from '../pages/AdminPage'
import TurbolinksAdapter from 'vue-turbolinks'

import backend from 'backend/axios-admin'
Vue.prototype.$backend = backend;
// Vue.use(Vuelidate)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#admin-app',
    render: h => h(AdminPage),
    store,
    router,
  }).$mount()
})
