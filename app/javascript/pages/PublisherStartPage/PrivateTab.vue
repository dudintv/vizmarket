<template lang="pug">
  #publisher-settings-private
    h5.mb-8 2. Personal Info (private)

    FormField(title="Official Name", description="This name useful for official documents and communication with the Marketplace.")
      template(#input)
        TextInput(name="Full name" v-model="private.fullName")
        TextInput(name="Company" v-model="private.company")

    FormField(title="Private contacts", description="They are hidden contacts and will be used only for communication with the Marketplace.")
      template(#input)
        TextInput(name="Phone number" v-model="private.phone")
        TextInput(name="Email for notices" v-model="private.email")
          template(#tip) By default it is your account email. We will send only technical publisher messages on this email.

    .flex.justify-end
      button.btn.third-btn.big-btn.mr-4(@click="cancel") cancel
      router-link.btn.second-btn.big-btn.mr-4(to="/publisher/author/start/public") Previous
      button.btn.main-btn.big-btn(@click="save") Save & Start
    
    div.mb-24
</template>

<script>
import FormField from 'components/inputs/FormField'
import TextInput from 'components/inputs/text'
export default {
  components: {
    FormField,
    TextInput,
  },
  props: {
    authorData: {},
  },
  data () {
    return {
      private: {
        fullName: '',
        company: '',
        phone: '',
        email: '',
      },
    }
  },
  computed: {
    author () {
      return this.$store.store.currentAuthor
    }
  },
  methods: {
    saveAuthor () {
      let author = { ...this.$store.state.currentAuthor } // copy object
      author.private = this.private
      this.$store.commit('setCurrentAuthor', author)
      this.$store.dispatch('saveAuthor')
    },
    cancel () {
      window.location.href = '/'
    },
    async save () {
      this.saveAuthor()
      await this.$store.dispatch('activateAuthor')
      router.push('/publisher')
    },
  }
}
</script>

<style lang="scss" scoped>

</style>
