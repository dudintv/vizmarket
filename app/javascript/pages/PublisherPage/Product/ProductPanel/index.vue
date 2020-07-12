<template lang="pug">
  .edit-product-panel(:class="bgClass")
    .nav
      ProductThumbnail(:product="product")
      ProductTitle(:product="product")
      .tabs
        router-link.tab(:to="`/publisher/products/${product.id}/title`")
          i.las.la-tag
          span Title & Category
        router-link.tab(:to="`/publisher/products/${product.id}/media`")
          i.las.la-photo-video
          span Images & Video
        router-link.tab(:to="`/publisher/products/${product.id}/texts`")
          i.las.la-align-left
          span Instructions
        router-link.tab.selected(:to="`/publisher/products/${product.id}/files`")
          i.las.la-file-upload
          span Product files
    .content
      router-view
    .status
      span.text-white-20 status:&nbsp;
      span {{ product.status }}
    .actions
      button.big-btn.third-btn Delete the draft
      button.big-btn.second-btn Save and continue later
      button.big-btn.main-btn(@click="doNext()") {{ nextButtonText }}
</template>

<script>
import ProductThumbnail from 'components/product/thumbnail'
import ProductTitle from 'components/product/title'

export default {
  components: {
    ProductThumbnail,
    ProductTitle,
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
    bgClass () {
      return this.product.status == 'published' ? 'bg-published' : 'bg-unpublished'
    },
    nextButtonText () {
      switch (this.$route.fullPath.split('/').slice(-1)[0]) {
        case 'title':
        case 'media':
        case 'texts': return 'Save and go next'
        case 'files': return 'Finish and publish'
        default: return 'Next'
      }
    },
  },
  mounted () {
    if (this.product == null || Object.getOwnPropertyNames(this.product).length <= 1 || this.product.id === undefined) {
      // needs to load currentProduct data
      if (+this.$route.params.id > 0) {
        this.$store.dispatch('loadCurrentProductData', this.$route.params.id)
      } else {
        this.$router.push('/publisher') // redirect to the dasboard
      }
    }
  },
  methods: {
    doNext () {
      switch (this.$route.fullPath.split('/').slice(-1)[0]) {
        case 'title':
          this.saveTitle()
          this.$router.push(`/publisher/products/${this.product.id}/media`)
          break
        case 'media':
          this.saveMedia()
          this.$router.push(`/publisher/products/${this.product.id}/texts`)
          break
        case 'texts':
          this.saveTexts()
          this.$router.push(`/publisher/products/${this.product.id}/files`)
          break
        case 'files':
          this.saveFiles()
          this.saveAndClose()
          break
        default: this.saveAndClose()
      }
    },
    saveAndClose () {
      console.log('SAVE AND CLOSE')
    },
    saveTitle () {
      console.log('SAVE TITLE')
    },
    saveMedia () {
      console.log('SAVE MEDIA')
      const formData = new FormData()

      fetch(this.product.thumbnail)
        .then( res => res.blob())
        .then( blob => {
          formData.append('thumbnail', blob_data)
          return this.$backend.products.upload_thumbnail(this.product.id, formData)
        })
        .then(response => {
          console.log('SUCCES', response)
        })
        .catch(error => {
          console.warn('ERROR', error)
        })
    },
    saveTexts () {
      console.log('SAVE TEXTS')
    },
    saveFiles () {
      console.log('SAVE FILES')
    },

    /**
     * Convert a base64 string in a Blob according to the data and contentType.
     * 
     * @param b64Data {String} Pure base64 string without contentType
     * @param contentType {String} the content type of the file i.e (image/jpeg - image/png - text/plain)
     * @param sliceSize {Int} SliceSize to process the byteCharacters
     * @see http://stackoverflow.com/questions/16245767/creating-a-blob-from-a-base64-string-in-javascript
     * @return Blob
     */
    b64toBlob (b64Data, contentType, sliceSize) {
        contentType = contentType || '';
        sliceSize = sliceSize || 512;

        var byteCharacters = atob(b64Data);
        var byteArrays = [];

        for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
            var slice = byteCharacters.slice(offset, offset + sliceSize);

            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }

            var byteArray = new Uint8Array(byteNumbers);

            byteArrays.push(byteArray);
        }

      var blob = new Blob(byteArrays, {type: contentType});
      return blob;
    },

  }
}
</script>

<style style="scss" scoped>
  .edit-product-panel {
    @apply shadow-2xl mb-8;
    display: grid;
    grid-template-columns: 284px auto;
    grid-template-rows: auto 100px;
    grid-template-areas: 
      "nav content"
      "status actions";
    min-width: 700px;
  }

  .nav {
    @apply flex flex-col;
    grid-area: nav;

    .tabs {
      @apply flex-grow bg-item-50;
    }

    .tab {
      @apply block px-4 py-6 text-xl;

      &.router-link-active {
        @apply bg-red;

        &:hover { @apply bg-red; }
      }

      i { @apply mr-6; }

      &:hover { @apply bg-item; }
    }
  }

  .content {
    @apply px-8 py-6;
    grid-area: content;
  }

  .status, .actions {
    @apply bg-item;
  }

  .status {
    @apply text-xl uppercase text-white-50 flex justify-center items-center;
    grid-area: status;
  }

  .actions {
    @apply flex justify-end items-center;
    grid-area: actions;

    button {
      @apply mr-8;
    }
  }

</style>
