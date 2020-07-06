import Vue from 'vue'
import VueRouter from 'vue-router'

const Product     = () => import('../Product')
const ProductList = () => import('../ProductsList')

const TitleTab = () => import('../Product/ProductPanel/TitleTab')
const MediaTab = () => import('../Product/ProductPanel/MediaTab')
const TextsTab = () => import('../Product/ProductPanel/TextsTab')
const FilesTab = () => import('../Product/ProductPanel/FilesTab')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/publisher', redirect: '/publisher/index' },
    { path: '/publisher/index', component: ProductList },
    {
      path: '/publisher/products/:id',
      component: Product,
      children: [
        { path: 'title', component: TitleTab },
        { path: 'media', component: MediaTab },
        { path: 'texts', component: TextsTab },
        { path: 'files', component: FilesTab },
      ]
    },
  ]
})
