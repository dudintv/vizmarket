import Vue from 'vue'
import store from '../pages/PublisherPage/store'
import ProductsApp from '../pages/PublisherPage/ProductsList'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ProductsApp),
    store
  }).$mount()
  document.getElementById('publisher-app').appendChild(app.$el)
})
