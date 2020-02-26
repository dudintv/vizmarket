import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentProduct: {
      id: 1,
      title: "Name of product",
      short_description: "",
      description: "",
      image: "/images/test-examples/thumbnails/thumb02.png",
      labels: ["new", "featured"],
      status: "draft",
      kind: "script",
      category: "position",

      versions: [
        {
          id: 1,
          number: "1.0",
          support: "VizArtist 3.13",
          status: "published",
          created_at: (new Date()).toString(),
          updated_at: (new Date()).toString(),
          files: [
            {
              filename: "2019_v1.0_SuperPlugin.vip",
              path: "/product/1/versions/1/2019_v1.0_SuperPlugin.vip",
            },
            {
              filename: "2020_v1.1_SuperPlugin.vip",
              path: "/product/1/versions/2/2020_v1.1_SuperPlugin.vip",
            },
          ]
        },
      ]
    },
  },
  mutations: {
    // changeVersionPublished (state, { version, status } ) {
    //   // state.currentProduct.versions[0].status = status
    //   version.status = status
    // }
  },
  actions: {
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
    }
  },
  modules: {},
  plugins: [],
})
