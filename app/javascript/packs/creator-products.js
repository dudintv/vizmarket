import Vue from 'vue'
import ProductsApp from '../creator'
import NewProductApp from '../creator/products/new'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ProductsApp)
  }).$mount()
  if (document.getElementById('creator-products-app'))
    document.getElementById('creator-products-app').appendChild(app.$el)
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(NewProductApp)
  }).$mount()
  if (document.getElementById('creator-new-product-app'))
    document.getElementById('creator-new-product-app').appendChild(app.$el)
})
