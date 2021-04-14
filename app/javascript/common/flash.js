import Vue from 'vue'
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)
import Flash from 'components/common/flash'

document.addEventListener("turbolinks:load", function() {
  console.log("[ flash.js turbolinks:load]")
  FlashVM?.$destroy()
  const FlashVM = new Vue(Flash)
  FlashVM.$mount('#flash-app')
  window.FlashVM = FlashVM
})
