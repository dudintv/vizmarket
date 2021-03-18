import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentAuthor: {
      links: {},
      support_contacts: {},
      private_contacts: {},
    },
  },
  getters: {},
  mutations: {
    setCurrentAuthor: (state, newAuthor) => {
      state.currentAuthor = newAuthor
    }
  },
  actions: {
    loadAuthor ({ commit }) {
      backend.author.get()
        .then(response => {
          let author = response.data.data.attributes
          commit('setCurrentAuthor', author)
        })
        .catch(error => {
          console.warn('Can\'t load data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    saveAuthor ({ state, commit, dispatch }, newAuthor) {
      commit('setCurrentAuthor', newAuthor)
      backend.author.update(state.currentAuthor)
        .then(() => {
          dispatch('loadAuthor')
        })
        .catch(error => {
          console.warn('Can\'t save data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
  },
})
