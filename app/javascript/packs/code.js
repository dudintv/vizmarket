import Prism from 'prism-es6'
import 'prism-es6/components/prism-visual-basic'
import 'prismjs/themes/prism-tomorrow.css'

function copyToClipboard(elemId){
  const code = document.getElementById(elemId).textContent
  navigator.clipboard.writeText(code)
    .then(() => {
      FlashVM.notice("Code is copied to clipboard")
      console.log("Ok. Code is copied to clipboard.")
    })
    .catch(err => {
      alert('ERROR: I can\'t put the script into your clipboard.')
      console.error('Error with coping to clipboard:', err)
    })
}

function setup() {
  Prism.highlightAll()
  window.copyToClipboard = copyToClipboard
}

document.addEventListener('turbolinks:load', () => {
  setup()
})

setup()
