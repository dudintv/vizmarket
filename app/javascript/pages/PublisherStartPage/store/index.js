import Vue from 'vue'
import Vuex from 'vuex'
import backend from 'backend/axios'
import { setObjectPropByPath, renameObjectKey } from 'common/helpers'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentAuthor: {
      support: {},
      links: {},
      private: {},
    },
  },
  getters: {},
  mutations: {
    setCurrentAuthor: (state, author) => {
      renameObjectKey(author, 'support_contacts', 'support')
      renameObjectKey(author, 'private_contacts', 'private')
      let newAuthor = {}
      setObjectPropByPath(newAuthor, ['name'], author.name ?? '')
      setObjectPropByPath(newAuthor, ['support', 'email'], author.support?.email ?? '')
      setObjectPropByPath(newAuthor, ['support', 'phone'], author.support?.phone ?? '')
      setObjectPropByPath(newAuthor, ['links', 'website'],  author.links?.website  ?? '')
      setObjectPropByPath(newAuthor, ['links', 'facebook'], author.links?.facebook ?? '')
      setObjectPropByPath(newAuthor, ['links', 'twitter'],  author.links?.twitter  ?? '')
      setObjectPropByPath(newAuthor, ['links', 'linkedin'], author.links?.linkedin ?? '')
      setObjectPropByPath(newAuthor, ['private', 'fullName'], author.private?.fullName ?? '')
      setObjectPropByPath(newAuthor, ['private', 'company'], author.private?.company ?? '')
      setObjectPropByPath(newAuthor, ['private', 'email'], author.private?.email ?? '')
      setObjectPropByPath(newAuthor, ['private', 'phone'], author.private?.phone ?? '')
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
    saveAuthor ({ state, dispatch }) {
      let author = { ...state.currentAuthor } // copy object
      renameObjectKey(author, 'support', 'support_contacts')
      renameObjectKey(author, 'private', 'private_contacts')
      backend.author.update(author) 
        .then(() => {
          dispatch('loadAuthor')
        })
        .catch(error => {
          console.warn('Can\'t save data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    activateAuthor () {
      backend.author.activate() 
        .then(() => {
          FlashVM.notice("Your publisher profile was successfully activated.")
        })
        .catch(error => {
          console.warn('Can\'t activate your publisher profile. Error: ', error)
          FlashVM.alert(error.message)
        })
    }
  },
  modules: {},
  plugins: [],
})
