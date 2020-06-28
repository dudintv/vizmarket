import Vue from 'vue'
import store from '../pages/PublisherPage/store'
import router from '../pages/PublisherPage/router'
import Vuelidate from 'vuelidate'
import ProductsApp from '../pages/PublisherPage'

import backend from '../backend/axios'
Vue.prototype.$backend = backend;
Vue.use(Vuelidate)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#publisher-app',
    render: h => h(ProductsApp),
    store,
    router,
  }).$mount()
})
