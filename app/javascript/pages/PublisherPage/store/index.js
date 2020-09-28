import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentUser: {},
    products: [],
    currentProduct: {},
    categoryList: [],
    kindList: [],

    // currentProduct: {
    //   id: 1,
    //   title: "Name of product",
    //   short_description: "",
    //   description: "",
    //   image: "/images/test-examples/thumbnails/thumb02.png",
    //   labels: ["new", "featured"],
    //   status: "draft",
    //   kind: "script",
    //   category: "position",

    //   versions: [
    //     {
    //       id: 1,
    //       number: "1.0",
    //       support: "VizArtist 3.13",
    //       status: "published",
    //       created_at: (new Date()).toString(),
    //       updated_at: (new Date()).toString(),
    //       files: [
    //         {
    //           filename: "2019_v1.0_SuperPlugin.vip",
    //           path: "/product/1/versions/1/2019_v1.0_SuperPlugin.vip",
    //         },
    //         {
    //           filename: "2020_v1.1_SuperPlugin.vip",
    //           path: "/product/1/versions/2/2020_v1.1_SuperPlugin.vip",
    //         },
    //       ]
    //     },
    //   ]
    // },

    // products: [
    //   {
    //     id: 1,
    //     cover: null,
    //     title: 'Random movement',
    //     short_description: 'Random besier movement single container with separated three dimensions.',
    //     created_at: '2019-12-31 02:09:38 UTC',
    //     updated_at: '2020-01-03 03:57:14 UTC',
    //     public: true,
    //     featured: false,
    //     kind: 'Script',
    //     category: 'Positioning',
    //     price: 100,
    //     price_original: 200,
    //     purchased_count: 14,
    //     rating: {
    //       average: 4.7,
    //       count: 35,
    //     },
    //     versions: [
    //       {
    //         number: 1.2,
    //         created_at: '2020-01-03 03:57:14 UTC',
    //         developed_for: 'developed for VizArtist 3.10 … 3.13',
    //         // tested_in: 'tested in VizArtist 3.13',
    //       },
    //       {
    //         number: 1.1,
    //         created_at: '2020-01-02 02:34:00 UTC',
    //         developed_for: 'developed for VizArtist 3.10',
    //         // tested_in: 'tested in VizArtist 3.10',
    //       },
    //       {
    //         number: 1.0,
    //         created_at: '2020-01-01 01:00:00 UTC',
    //         developed_for: 'developed for VizArtist 3.8',
    //         // tested_in: 'tested in VizArtist 3.8',
    //       },
    //     ]
    //   }
    // ],

    // categoryList: [
    //   "transformation",
    //   "visibility",
    //   "animation",
    //   "texture",
    //   "interactive",
    //   "utility",
    //   "other",
    // ],
    // kindList: [
    //   "script",
    //   "scene",
    //   "plugin",
    //   "assets",
    // ],

    filter: 'all',
    sort: {},
    isGrouped: false,
  },
  getters: {
    publics: state => {
      return state.products.filter(product => !!product.public)
    },
    drafts: state => {
      return state.products.filter(product => !product.public)
    },
    // pendings: state => {
    //   return state.products.filter(product => !!product.public && !product.aproved)
    // },
    filteredProducts: (state, getters) => {
      switch(state.filter.toLowerCase()){
        case 'published':
          return getters.publics
        case 'drafts':
          return getters.drafts
        case 'pendings':
          return getters.pendings
      }
      return state.products
    },
    filteredAndSortedProducts: (state, getters) => {
      const sortField = state.sort.field
      const isSortOrderUpToDown = state.sort.order == 'desc'
      return getters.filteredProducts.sort((product1, product2) => {
        if (product1[sortField] == product2[sortField]) {
          return 0
        } else {
          const result = product1[sortField] > product2[sortField] ? 1 : -1
          return isSortOrderUpToDown ? result*-1 : result
        }
      })
    },
    filteredAndSortedAndGroupedProducts: (state, getters) => {
      if (state.isGrouped) {
        return getters.filteredAndSortedProducts.sort((product1, product2) => {
          if (product1.kind === product2.kind) {
            return 0
          } else {
            return product1.kind > product2.kind ? 1 : -1
          }
        })
      } else {
        return getters.filteredAndSortedProducts
      }
    }
  },
  mutations: {
    setCategories: (state, categoryList) => {
      state.categoryList = categoryList
    },
    setKinds: (state, kindList) => {
      state.kindList = kindList
    },
    setCurrentUser: (state, newUser) => {
      state.currentUser = newUser
    },
    setCurrentAuthor: (state, newAuthor) => {
      state.currentAuthor = newAuthor
    },
    setProducts: (state, productsData) => {
      state.products = productsData
    },
    setCurrentProduct: (state, productData) => {
      state.currentProduct = productData
    },
    setProductVersions: (state, vesrionsData) => {
      state.currentProduct.versions = vesrionsData
    },
    setFilter: (state, newFilter) => {
      state.filter = newFilter
    },
    setSort: (state, newSort) => {
      state.sort = newSort
    },
    setGrouped: (state, newGrouped) => {
      state.isGrouped = newGrouped
    },
    setYoutubeIds: (state, newIds) => {
      state.currentProduct.youtube_ids = newIds
    },
    setImages: (state, images) => {
      state.currentProduct.images = images
    },
    removeGalleryImage: (state, key) => {
      const index = state.currentProduct.images.findIndex(el => el.key === key)
      if (index >= 0) {
        state.currentProduct.images.splice(index, 1)
      }
    },
    changeProductPublic: (state, payload) => {
      const product = state.products.find(p => p.id === payload.id)
      product.public = payload.newPublic
    }
  },
  actions: {
    loadCurrentUser ({ commit }) {
      backend.user.get()
        .then(response => {
          commit('setCurrentUser', response.data.data.attributes)
        })
        .catch(error => {
          console.warn('Can\'t load current user data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    loadCurrentAuthor ({ commit }) {
      backend.author.get()
        .then(response => {
          commit('setCurrentAuthor', response.data.data.attributes)
        })
        .catch(error => {
          console.warn('Can\'t load current author data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    loadProducts ({ commit }) {
      backend.products.index()
        .then(response => {
          let products = response.data.data.map(el => el.attributes)
          commit('setProducts', products)
        })
        .catch(error => {
          console.warn('Can\'t load products data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    loadTaxonomy ({ commit }) {
      backend.products.new()
        .then(response => {
          commit('setCategories', response.data.categories)
          commit('setKinds', response.data.kinds)
        })
        .catch(error => {
          console.warn('Can\'t load taxonomy data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    loadCurrentProductData ({ commit }, id) {
      backend.products.get(id)
        .then(response => {
          commit('setCurrentProduct', response.data.data.attributes)
        })
        .catch(error => {
          console.warn('Can\'t load current product data. Error: ', error)
          FlashVM.alert(error.message)
        }) 
    },
    updateVersionsList ({ commit, state }){
      backend.versions.index(state.currentProduct.id)
        .then(response => {
          console.debug("response.data.data", response.data.data.map(el => el.attributes))
          commit('setProductVersions', response.data.data.map(el => el.attributes))
        })
        .catch(error => {
          console.warn('Can\'t load versions data. Error: ', error)
          FlashVM.alert(error.message)
        }) 
    },
    versionPublishedChanged ({ commit, state}, { version, isPublished }) {
      if (isPublished) {
        return new Promise((resolve, reject) => {
          backend.versions.publish(version.id)
            .then(response => {
              resolve(response.data.public)
            })
            .catch(error => {
              console.warn('Can\'t publish version. Error: ', error)
              FlashVM.alert(error.message)
              reject()
            }) 
        })
      } else {
        return new Promise((resolve, reject) => {
          backend.versions.unpublish(version.id)
            .then(response => {
              resolve(response.data.public)
            })
            .catch(error => {
              console.warn('Can\'t unpublish version. Error: ', error)
              FlashVM.alert(error.message)
              reject()
            })
        })
      }
    },
  },
  modules: {},
  plugins: [],
})
