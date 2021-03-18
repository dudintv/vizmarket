<template lang="pug">
  #publisher-author-app
    h1 Edit Publisher settings

    .form-container
      h5.mb-8 1. Store Info (public), how your customers get your support
      
      FormField(:required="true", title="Publisher Name", description="This name will be showed on your product cards.")
        template(#input)
          TextInput(name="Store Name" v-model="author.name" required)

      FormField(title="Public contacts" description="It's contacts for your customers.")
        template(#input)
          TextInput(name="Support Email" v-model="author.support_contacts.email" type="email")
          TextInput(name="Support Phone" v-model="author.support_contacts.phone" type="tel")

      FormField(title="Public links" description="Where your customers can find you.")
        template(#input)
          TextInput(name="Your website"  v-model="author.links.website")
          TextInput(name="Facebook link" v-model="author.links.facebook")
          TextInput(name="Twitter link"  v-model="author.links.twitter")
          TextInput(name="LinkedIn link" v-model="author.links.linkedin")

      h5.mb-8 2. Legal Info (private)

      FormField(title="Official Name", description="This name useful for official documents and communication with the Marketplace.")
        template(#input)
          TextInput(name="Full name" v-model="author.private_contacts.fullName")
          TextInput(name="Company" v-model="author.private_contacts.company")

      FormField(title="Private contacts", description="They are hidden contacts and will be used only for communication with the Marketplace.")
        template(#input)
          TextInput(name="Phone number" v-model="author.private_contacts.phone" id="private_phone_number" type="tel")
          TextInput(name="Email for notices" v-model="author.private_contacts.email" type="email")
            template(#tip) By default it is your account email. We will send only technical publisher messages on this email.

      .flex.justify-end
        button.btn.third-btn.big-btn.mr-4(@click="cancel") cancel
        button.btn.main-btn.big-btn(@click="save") Save 
      
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
  computed: {
    author: {
      get () { return this.$store.state.currentAuthor },
      set (value) { this.$store.commit('setCurrentAuthor', value) }
    }
  },
  mounted () {
    this.$store.dispatch('loadAuthor')
  },
  methods: {
    cancel () {
      window.location.href = '/publisher'
    },
    async save () {
      await this.$store.dispatch('saveAuthor', this.author)
      window.location.href = '/publisher'
    },
  }
}
</script>

<style lang="scss" scoped>

</style>
