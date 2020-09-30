<template lang="pug">
  #settings-password
    form
      TextInput(name="Current password" v-model="currentPassword" type="password" required)
      TextInput(name="New password" v-model="newPassword" type="password" required)
      TextInput(name="Repeat new password" v-model="repeatPassword" type="password" required)
      button.btn.main-btn.big-btn(@click.prevent="save()") Save
</template>

<script>
import TextInput from "components/inputs/text.vue"

export default {
  components: {
    TextInput,
  },
  data () {
    return {
      currentPassword: '',
      newPassword: '',
      repeatPassword: '',
    }
  },
  methods: {
    save () {
      this.$store.dispatch('saveNewPassword', { currentPassword: this.currentPassword, newPassword: this.newPassword })
      this.currentPassword = ''
      this.newPassword = ''
      this.repeatPassword = ''
    }
  }
}
</script>

<style scoped>
</style>
