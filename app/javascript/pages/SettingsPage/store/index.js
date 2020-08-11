import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {},
  },
  getters: {
    user: state => {
      return state.user
    }
  },
  mutations: {
    setUser (state, newUser) {
      state.user = newUser
    }
  },
  actions: {
    loadUser ({ commit }) {
      backend.settings.userData()
        .then(response => {
          console.debug("response.data.data", response.data.data)
          commit('setUser', response.data.data.attributes)
        })
        .catch(error => {
          console.warn('Can\'t load settings data. Error: ', error)
          FlashVM.alert(error.message)
        })
    }
  },
  modules: {},
  plugins: [],
})
