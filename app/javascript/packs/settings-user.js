import Vue from 'vue'
import store from '../pages/SettingsUserPage/store'
import router from '../pages/SettingsUserPage/router'
import Vuelidate from 'vuelidate'
import TurbolinksAdapter from 'vue-turbolinks'

import SettingsUserApp from '../pages/SettingsUserPage'

import backend from 'backend/axios'
Vue.prototype.$backend = backend;
Vue.use(Vuelidate)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#settings-user-app',
    render: h => h(SettingsUserApp),
    store,
    router,
  }).$mount()
})
