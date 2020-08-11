<template lang="pug">
  #settings-general
    ImageInput(name="Avatar" v-model="user.avatar" recommendations="Your avatar" :isLoading="isAvatarLoading" :successMessage="avatarSuccessMessage" :errorMessage="avatarErrorMessage")
    TextInput(name="Name" v-model="user.name")
    TextInput(name="Surname" v-model="user.surname")
    TextInput(name="Job title" v-model="user.jobtitle")
    TextInput(name="Country" v-model="user.country")
    TextareaInput(name="About" v-model="user.about")
    button.btn.main-btn.big-btn Save
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
      user: {},
      isAvatarLoading: false,
      avatarSuccessMessage: '',
      avatarErrorMessage: '',
    }
  },
  activated () {
    this.user = this.$store.getters.user
  },
}
</script>

<style scoped>
</style>
