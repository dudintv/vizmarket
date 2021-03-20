import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentUser: {},
    invitations: [],
  },
  getters: {},
  mutations: {
    setCurrentUser (state, newUser) {
      state.currentUser = newUser
    },
    setAvatar (state, newAvatar) {
      state.currentUser.avatar = newAvatar
    },
    setInvitations (state, newInvitations) {
      state.invitations = newInvitations
    },
    addInvitations (state, newInvitations) {
      state.invitations.push(...Array.from(newInvitations))
    }
  },
  actions: {
    loadUser ({ commit }) {
      backend.user.get()
        .then(response => {
          const user = response.data.data.attributes
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
    saveNewPassword ({}, { currentPassword, newPassword }) {
      backend.user.updatePassword(currentPassword, newPassword)
        .then(() => {
          window.location.href = '/'
          FlashVM.notice('Password was successfuly updated.')
        })
        .catch(error => {
          console.warn('Can\'t save data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    destroyAccountLink ({ dispatch }, account) {
      backend.user.destroyAccountLink(account)
        .then(() => {
          dispatch('loadUser')
          FlashVM.notice('Linked account was successfuly delete.')
        })
        .catch(error => {
          console.warn('Can\'t delete. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    loadInvitations ({ commit }) {
      backend.user.getInvitationsList()
        .then(response => {
          console.log('response.data =', response.data)
          const invitations = response.data.invitations
          commit('setInvitations', invitations)
        })
        .catch(error => {
          console.warn('Can\'t load data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    createInvitations ({ commit }) {
      backend.user.createInvitations()
        .then(response => {
          console.log('response.data =', response.data)
          const new_invitations = response.data.invitations
          commit('addInvitations', new_invitations)
        })
        .catch(error => {
          console.warn('Can\'t load data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
  },
  modules: {},
  plugins: [],
})
