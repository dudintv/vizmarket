import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentProduct: {
      title: "Name of product",
      image: "/images/test-examples/thumbnails/thumb02.png",
      labels: ["new", "featured"],
    },
  },
  mutation: {},
  actions: {},
  modules: {},
  plugins: [],
})
