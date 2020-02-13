import Vue from 'vue'
import store from '../creator/store'
import ProductsApp from '../creator'
import NewProductApp from '../creator/ProductEditPage/new'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ProductsApp),
    store
  }).$mount()
  if (document.getElementById('creator-products-app'))
    document.getElementById('creator-products-app').appendChild(app.$el)
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(NewProductApp),
    store
  }).$mount()
  if (document.getElementById('creator-new-product-app'))
    document.getElementById('creator-new-product-app').appendChild(app.$el)
})
