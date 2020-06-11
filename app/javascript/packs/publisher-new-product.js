import Vue from 'vue'
import store from '../pages/PublisherPage/store'
import NewProductApp from '../pages/PublisherPage/ProductNew'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(NewProductApp),
    store
  }).$mount()
  document.getElementById('publisher-new-product-app').appendChild(app.$el)
})
