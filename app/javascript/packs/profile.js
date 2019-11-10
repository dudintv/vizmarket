import Vue from 'vue'
import App from '../profile'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.getElementById('profile-app').appendChild(app.$el)
})
