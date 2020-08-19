<template lang="pug">
  #settings-password
    TextInput(name="New password" v-model="password")
    TextInput(name="Repeat new password" v-model="repeat_password")
    button.btn.main-btn.big-btn Save
</template>

<script>
import TextInput from "components/inputs/text.vue"

export default {
  components: {
    TextInput,
  },
  data () {
    return {
      password: '',
      repeat_password: '',
    }
  },
}
</script>

<style scoped>
</style>
