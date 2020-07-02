<template lang="pug">
  #toasts
    Flash(v-for="message in messages" :kind="message[0]" :message="message[1]")
</template>

<script>
import Flash from './Flash'
export default {
  components: {
    Flash
  },
  data () {
    return {
      messages: [],
    }
  },
  mounted () {
    let flashFromServer = document.getElementById('flashData')
    flashFromServer.dataset.notice  && this.notice (flashFromServer.dataset.notice)
    flashFromServer.dataset.alert   && this.alert  (flashFromServer.dataset.alert)
    flashFromServer.dataset.warning && this.warning(flashFromServer.dataset.warning)
    flashFromServer.dataset.error   && this.error  (flashFromServer.dataset.error)
  },
  methods: {
    notice (message) {
      this.toast ('notice', message)
    },
    alert (message) {
      this.toast ('alert', message)
    },
    warning (message) {
      this.toast ('warning', message)
    },
    error (message) {
      this.toast ('error', message)
    },
    toast (kind, message) {
      // make a toast with auto-deleting
      this.messages.push([kind, message])
      setTimeout(() => {
        this.messages.shift()
      }, 5000)
    }
  }
}
</script>

<style>
#toasts {
  @apply absolute right-2 top-2 z-80 flex flex-row;
}
</style>
