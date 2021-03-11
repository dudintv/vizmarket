<template lang="pug">
#feedback-messages-page
  h1 Contact to Marketplace team


  .all-messages.flex.flex-col.mx-16
    .flex.justify-center
      a.cursor-pointer(@click="isShowAllMessages = !isShowAllMessages") Show all my messages
    .message(v-if="isShowAllMessages")
      .bg-item.px-4.py-2.my-2(v-for="message of messages")
        p {{ message.attributes.message }}
        p {{ message.attributes.contacts }}
        p {{ message.attributes.created_at }}

  .form-container
    FormField(:required="true", title="Message", description="Please write down your feedback or claim.")
      template(#input)
        TextareaInput(name="Message" v-model="message" required)
    FormField(:required="false", title="Contacts", description="Leave your contact if you want us to answer you.")
      template(#input)
        TextInput(name="Contacts" v-model="contacts")
    .w-full.flex.justify-center
      button.main-btn.big-btn.uppercase(type="submit" @click="send") Send
</template>

<script>
import FormField from 'components/inputs/FormField'
import TextInput from 'components/inputs/text'
import TextareaInput from "components/inputs/textarea.vue"

export default {
  components: {
    FormField,
    TextInput,
    TextareaInput,
  },
  data () {
    return {
      messages: [],
      message: '',
      contacts: '',
      isShowAllMessages: false,
    }
  },
  watch: {
    isShowAllMessages (value) {
      console.log('this.isShowAllMessages =', this.isShowAllMessages)
      if (value) {
        this.$backend.feedbackMessages.index()
          .then((response) => {
            console.log('response =', response)
            this.messages = response.data.data
          })
      }
    }
  },
  mounted () {
    this.$backend.feedbackMessages.new()
      .then((response) => {
        console.log('response =', response)
        this.message = response.data.message
        this.contacts = response.data.contacts
      })
  },
  methods: {
    send () {
      const message = this.message
      const contacts = this.contacts
      this.$backend.feedbackMessages.create({ feedback: { message, contacts } })
        .then(() => {
          FlashVM.notice('Successfully sended')
          this.message = ''
          this.isShowAllMessages = false
        })
        .catch(error => {
          FlashVM.error(`Can't send message with error: ${error}`)
        })
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
