import '../components/common/fotorama/fotorama'
import '../components/common/fotorama/fotorama.css'

document.addEventListener('turbolinks:load', () => {
  $(function () {
    // example of how to improve it — https://codepen.io/pnmcosta/pen/jBeNrm
    // let fotoramaWidth, fotoramaHeight;
    $('.fotorama')
    .on('fotorama:fullscreenenter', () => {
      // console.log('fullscreenenter')
    })
    .on('fotorama:fullscreenexit', () => {
      // console.log('fullscreenexit')
    })
    .fotorama({
      nav: 'thumbs',
      fit: 'cover',
    });
  });
})
