import Prism from 'prism-es6'
import 'prism-es6/components/prism-visual-basic'
import 'prismjs/themes/prism-tomorrow.css'

function copyToClipboard(elemId){
  const code = document.getElementById(elemId).textContent
  navigator.clipboard.writeText(code)
    .then(() => {
      // alert('Code is copied')
      console.log("Ok. Code is copied to clipboard.")
    })
    .catch(err => {
      alert('ERROR: I can\'t put the script into your clipboard.')
      console.error('Error with coping to clipboard:', err)
    })
}

document.addEventListener('turbolinks:load', () => {
  Prism.highlightAll()
  // const el = document.getElementById('product-code')
  // Prism.highlightElement(document.getElementById('product-code'))

  console.log('[ code.js turbolinks:load ]')
  window.copyToClipboard = copyToClipboard
})
