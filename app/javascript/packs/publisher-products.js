import Vue from 'vue'
import store from '../pages/PublisherPage/store'
import ProductsApp from '../pages/PublisherPage/ProductsList'
import NewProductApp from '../pages/PublisherPage/ProductNew'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ProductsApp),
    store
  }).$mount()
  if (document.getElementById('publisher-products-app'))
    document.getElementById('publisher-products-app').appendChild(app.$el)
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(NewProductApp),
    store
  }).$mount()
  if (document.getElementById('publisher-new-product-app'))
    document.getElementById('publisher-new-product-app').appendChild(app.$el)
})
