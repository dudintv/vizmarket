import Vue from 'vue'
import router from '../pages/PublisherAuthorPage/router'
import Vuelidate from 'vuelidate'
import TurbolinksAdapter from 'vue-turbolinks'

import PublisherAuthorApp from '../pages/PublisherAuthorPage'

import backend from 'backend/axios'
Vue.prototype.$backend = backend;
Vue.use(Vuelidate)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#publisher-author-app',
    render: h => h(PublisherAuthorApp),
    router,
  }).$mount()
})
