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
          number: "1.0",
          support: "VizArtist 3.13",
          status: "published",
          created_at: (new Date()).toString(),
          updated_at: (new Date(Date().now+1)).toString(),
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
  mutation: {},
  actions: {},
  modules: {},
  plugins: [],
})
