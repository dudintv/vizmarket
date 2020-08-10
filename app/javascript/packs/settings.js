import Vue from 'vue'
import store from '../pages/SettingsPage/store'
import router from '../pages/SettingsPage/router'
import Vuelidate from 'vuelidate'
import TurbolinksAdapter from 'vue-turbolinks'

import SettingsApp from '../pages/SettingsPage'

import backend from 'backend/axios'
Vue.prototype.$backend = backend;
Vue.use(Vuelidate)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#settings-app',
    render: h => h(SettingsApp),
    store,
    router,
  }).$mount()
})
