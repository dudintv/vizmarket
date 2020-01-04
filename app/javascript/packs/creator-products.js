import Vue from 'vue'
import App from '../creator/products'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.getElementById('creator-products-app').appendChild(app.$el)
})
