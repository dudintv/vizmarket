import Vue from 'vue'
import store from '../pages/PublisherPage/store'
import router from '../pages/PublisherPage/router'
import Vuelidate from 'vuelidate'
import PublisherApp from '../pages/PublisherPage'
import TurbolinksAdapter from 'vue-turbolinks'

import backend from 'backend/axios'
Vue.prototype.$backend = backend;
Vue.use(Vuelidate)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#publisher-app',
    render: h => h(PublisherApp),
    store,
    router,
  }).$mount()
})
