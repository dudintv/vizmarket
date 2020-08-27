<template lang="pug">
  #publisher-settings-public
    h5.mb-8 1. Store Info (public), how your customers can get support
    
    FormField(:required="true", title="Publisher Name", description="This name will be showed on your product cards.")
      template(#input)
        TextInput(name="Store Name" v-model="author.name")

    FormField(title="Public contacts" description="It's contacts for your customers.")
      template(#input)
        TextInput(name="Support Email" v-model="author.support.email")
        TextInput(name="Support Phone" v-model="author.support.phone")

    FormField(title="Public links" description="Where your customers can find you.")
      template(#input)
        TextInput(name="Your website"  v-model="author.links.website")
        TextInput(name="Facebook link" v-model="author.links.facebook")
        TextInput(name="Twitter link"  v-model="author.links.twitter")
        TextInput(name="LinkedIn link" v-model="author.links.linkedin")

    .flex.justify-end
      button.btn.third-btn.big-btn.mr-4(@click="cancel") Cancel
      button.btn.main-btn.big-btn(@click="next") Next

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
  data () {
    return {
      author: {},
    }
  },
  beforeMount () {
    this.author = this.$store.state.currentAuthor
  },
  methods: {
    saveAuthor () {
      let author = { ...this.$store.state.currentAuthor } // copy object
      author.name = this.author.name
      author.support = this.author.support
      author.links = this.author.links
      this.$store.commit('setCurrentAuthor', author)
      this.$store.dispatch('saveAuthor')
    },
    cancel () {
      window.location.href = '/'
    },
    next () {
      this.saveAuthor()
      this.$router.push('/publisher/author/start/private')
    },
  }
}
</script>

<style lang="scss" scoped>

</style>
