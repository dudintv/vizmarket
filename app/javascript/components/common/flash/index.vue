<template lang="pug">
  #toasts
    Flash(
      v-for="message in messages" 
      :kind="message.kind" 
      :message="message.message" 
      :key="message.time"
      :time="message.time"
      @deleteToast="deleteToast"
    )
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
      const time = Date.now()
      const timer = setTimeout(() => {
        this.deleteToast (time)
      }, 10000)
      this.messages.push({ kind, message, time, timer })
    },
    deleteToast (time) {
      const index = this.messages.findIndex(toast => toast.time == time)
      if (index > -1) {
        clearInterval(this.messages[index].timer)
        this.messages.splice(index, 1)
      }
    },
  }
}
</script>

<style>
#toasts {
  @apply sticky right-2 top-2 flex flex-col;
  z-index: 200;
}
</style>
