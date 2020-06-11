import Vue from 'vue'
import Test from '../pages/Tests'

import router from '../pages/Tests/router'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#test-app',
    render: h => h(Test),
    router
  }).$mount()
})
