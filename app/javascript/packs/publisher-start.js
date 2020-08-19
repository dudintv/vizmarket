import Vue from 'vue'
import router from '../pages/PublisherStartPage/router'
import Vuelidate from 'vuelidate'
import TurbolinksAdapter from 'vue-turbolinks'

import PublisherStartApp from '../pages/PublisherStartPage'

import backend from 'backend/axios'
Vue.prototype.$backend = backend;
Vue.use(Vuelidate)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#settings-app',
    render: h => h(PublisherStartApp),
    router,
  }).$mount()
})
