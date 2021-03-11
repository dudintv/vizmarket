import Vue from 'vue'
import FeedbackMessagesApp from '../pages/FeedbackMessages'
import TurbolinksAdapter from 'vue-turbolinks'

import backend from 'backend/axios'
Vue.prototype.$backend = backend;
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#feedback-messages-app',
    render: h => h(FeedbackMessagesApp),
  }).$mount()
})
