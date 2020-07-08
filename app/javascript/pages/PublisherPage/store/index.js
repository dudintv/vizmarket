import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentProduct: {},
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
    products: [
      {
        id: 1,
        cover: null,
        title: 'Random movement',
        short_description: 'Random besier movement single container with separated three dimensions.',
        created_at: '2019-12-31 02:09:38 UTC',
        updated_at: '2020-01-03 03:57:14 UTC',
        public: true,
        featured: false,
        kind: 'Script',
        category: 'Positioning',
        price: 100,
        price_original: 200,
        purchased_count: 14,
        rating: {
          average: 4.7,
          count: 35,
        },
        versions: [
          {
            number: 1.2,
            created_at: '2020-01-03 03:57:14 UTC',
            developed_for: 'developed for VizArtist 3.10 … 3.13',
            // tested_in: 'tested in VizArtist 3.13',
          },
          {
            number: 1.1,
            created_at: '2020-01-02 02:34:00 UTC',
            developed_for: 'developed for VizArtist 3.10',
            // tested_in: 'tested in VizArtist 3.10',
          },
          {
            number: 1.0,
            created_at: '2020-01-01 01:00:00 UTC',
            developed_for: 'developed for VizArtist 3.8',
            // tested_in: 'tested in VizArtist 3.8',
          },
        ]
      }
    ],
    categoryList: [
      "transformation",
      "visibility",
      "animation",
      "texture",
      "interactive",
      "utility",
      "other",
    ],
    kindList: [
      "script",
      "scene",
      "plugin",
      "assets",
    ],
    filter: 'all',
  },
  getters: {
    published: state => {
      return state.products.filter(product => !!product.published)
    },
    drafts: state => {
      return state.products.filter(product => !product.published)
    },
    pendings: state => {
      return state.products.filter(product => !!product.published && !product.aproved)
    },
    filteredProducts: (state, getters) => {
      switch(state.filter.toLowerCase()){
        case 'published':
          return getters.published
        case 'drafts':
          return getters.drafts
        case 'pendings':
          return getters.pendings
      }
      return state.products
    },
  },
  mutations: {
    setCurrentProduct: (state, productData) => {
      state.currentProduct = productData
    },
    changeFilter: (state, newFilter) => {
      state.filter = newFilter
    },
    setYoutubeIds: (state, newIds) => {
      state.currentProduct.youtube_ids = newIds
    },
  },
  actions: {
    loadCurrentProductData ({ commit }, id) {
      backend.products.get(id)
        .then(response => {
          commit('setCurrentProduct', response.data.data.attributes)
        })
        .catch(error => {
          console.alert('Can\'t load current product data. Error: ', error)
          FlashVM.alert(error)
        }) 
    },
    versionPublishedChanged ({ commit, state}, { version, is_published }) {
      console.log(is_published)
      let status
      if (version.created_at) {
        status = is_published ? "published" : "unpublished"
      } else {
        // if the version not saved (because it's new one) it could be a "draft"
        status = is_published ? "published" : "draft"
      }
      // TODO: AXIOS
      version.status = status

      console.log(state.currentProduct.versions[0].status)
    },
  },
  modules: {},
  plugins: [],
})
