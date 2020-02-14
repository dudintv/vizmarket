import Vue from 'vue'
import App from '../pages/ProfilePage'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.getElementById('profile-app').appendChild(app.$el)
})
