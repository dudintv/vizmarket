import Vue from 'vue'
import Flash from 'components/common/flash'
const FlashVM = new Vue(Flash)
window.FlashVM = FlashVM

document.addEventListener("turbolinks:load", function() {
  FlashVM.$mount('#flash')
})
