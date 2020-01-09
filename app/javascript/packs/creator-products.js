import Vue from 'vue'
import App from '../creator'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.getElementById('creator-products-app').appendChild(app.$el)
})
