<template lang="pug">
  #settings-general
    ImageInput(name="Avatar" v-model="avatar" recommendations="Your avatar" :isLoading="isAvatarLoading" :successMessage="avatarSuccessMessage" :errorMessage="avatarErrorMessage")
    TextInput(name="Name" v-model="user.name")
    TextInput(name="Surname" v-model="user.surname")
    TextInput(name="Job title" v-model="user.jobtitle")
    TextInput(name="Country" v-model="user.country")
    TextareaInput(name="About" v-model="user.about")
    button.btn.main-btn.big-btn(@click="save()") Save
    
    .bg-body-darker.p-8.mt-16.text-white-30.hover--text-white-80
      h3 Request to delete the account
      p.my-4
        //- | Click the button to begin destroing your account with all history, purcheses. Also, you lose all your earned money that you didn’t withdraw. We recomend to get it before delete account!
        //- | Click the button begin destroing your account with all your products and history.
        //- | The account will be available to restore for 30 days. After that, it will be automatically totally deleted in databases.
        | Click the button to begin destroing your account with all your history.
      a.btn.second-btn.big-btn(href='/settings/destroy_my_account' data-method="delete") Delete account
</template>

<script>
import TextInput     from "components/inputs/text.vue"
import TextareaInput from "components/inputs/textarea.vue"
import ImageInput    from "components/inputs/image.vue"

export default {
  components: {
    TextInput,
    TextareaInput,
    ImageInput,
  },
  data () {
    return {
      isAvatarLoading: false,
      avatarSuccessMessage: '',
      avatarErrorMessage: '',
    }
  },
  computed: {
    user: {
      get () { return this.$store.state.currentUser },
      set (value) { this.$store.commit('setCurrentUser', value) }
    },
    avatar: {
      get () { return this.$store.state.currentUser.avatar },
      set (value) { this.$store.commit('setAvatar', value) }
    },
  },
  mounted () {
    this.loadUser()
  },
  watch: {
    avatar (newAvatar) {
      this.isAvatarLoading = true
      if (this.avatar) {
        // UPLOAD IMAGE
        fetch(this.avatar)
          .then( res => res.blob())
          .then( blob => {
            const formData = new FormData()
            formData.append('avatar', blob)
            return this.$backend.user.uploadAvatar(formData)
          })
          .then(response => {
            this.avatarSuccessMessage = 'Loaded successfully'
            this.avatarErrorMessage = ''
            setTimeout(() => {
              this.avatarSuccessMessage = ''
            }, 2000)
            console.log('SUCCES', response)
          })
          .catch(error => {
            this.avatarErrorMessage = error.message
            console.warn('ERROR', error)
          })
          .finally(() => {
            this.isAvatarLoading = false
          })
      } else {
        // DELETE IMAGE
        this.$backend.user.deleteAvatar()
          .then(response => {
            this.avatarSuccessMessage = 'Deleted successfully'
            this.avatarErrorMessage = ''
            setTimeout(() => {
              this.avatarSuccessMessage = ''
            }, 2000)
            console.log('SUCCES', response)
          })
          .catch(error => {
            this.avatarErrorMessage = error
            console.warn('ERROR', error)
          })
          .finally(() => {
            this.isAvatarLoading = false
          })
      }
    },
  },
  methods: {
    loadUser () {
      this.$backend.user.get()
        .then(response => {
          this.user = response.data.data.attributes
        })
        .catch(error => {
          console.warn('Can\'t load user data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    save () {
      this.$store.dispatch('saveUser')
    }
  }
}
</script>

<style scoped>
</style>
