import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentProduct: {
      title: "Name of product",
      short_description: "",
      description: "",
      image: "/images/test-examples/thumbnails/thumb02.png",
      labels: ["new", "featured"],
      status: "draft",
      kind: "script",
      category: "position", 
    },
  },
  mutation: {},
  actions: {},
  modules: {},
  plugins: [],
})
