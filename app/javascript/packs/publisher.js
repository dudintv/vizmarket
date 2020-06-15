import Vue from 'vue'
import store from '../pages/PublisherPage/store'
import router from '../pages/PublisherPage/router'
import ProductsApp from '../pages/PublisherPage'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#publisher-app',
    render: h => h(ProductsApp),
    store,
    router,
  }).$mount()
})
