import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentUser: {},
  },
  getters: {},
  mutations: {
    setCurrentUser (state, newUser) {
      state.currentUser = newUser
    }
  },
  actions: {
    loadUser ({ commit }) {
      backend.user.get()
        .then(response => {
          let user = response.data.data.attributes
          commit('setCurrentUser', user)
        })
        .catch(error => {
          console.warn('Can\'t load data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    saveUser ({ state, dispatch }) {
      backend.user.update(state.currentUser) 
        .then(() => {
          dispatch('loadUser')
          FlashVM.notice('User data was successfuly updated.')
        })
        .catch(error => {
          console.warn('Can\'t save data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    saveNewPassword ({ state }, { currentPassword, newPassword }) {
      backend.user.updatePassword(currentPassword, newPassword)
        .then(() => {
          window.location.href = '/'
          FlashVM.notice('Password was successfuly updated.')
        })
        .catch(error => {
          console.warn('Can\'t save data. Error: ', error)
          FlashVM.alert(error.message)
        })
    }
  },
  modules: {},
  plugins: [],
})
