import Vue from 'vue'
import VueRouter from 'vue-router'

const ProductNew  = () => import('../ProductNew')
const ProductList = () => import('../ProductsList')

const TitleTab = () => import('../ProductNew/ProductPanel/TitleTab')
const MediaTab = () => import('../ProductNew/ProductPanel/MediaTab')
const TextsTab = () => import('../ProductNew/ProductPanel/TextsTab')
const FilesTab = () => import('../ProductNew/ProductPanel/FilesTab')

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/publisher', redirect: '/publisher/index' },
    {
      path: '/publisher/new',
      component: ProductNew,
      children: [
        { path: 'title', component: TitleTab },
        { path: 'media', component: MediaTab },
        { path: 'texts', component: TextsTab },
        { path: 'files', component: FilesTab },
      ]
    },
    { path: '/publisher/index', component: ProductList },
  ]
})
