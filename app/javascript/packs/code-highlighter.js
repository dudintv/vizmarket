import Prism from 'prism-es6'
import 'prism-es6/components/prism-visual-basic'
import 'prismjs/themes/prism-tomorrow.css'

document.addEventListener('turbolinks:load', () => {
  Prism.highlightAll()
  // const el = document.getElementById('product-code')
  // Prism.highlightElement(document.getElementById('product-code'))
})
