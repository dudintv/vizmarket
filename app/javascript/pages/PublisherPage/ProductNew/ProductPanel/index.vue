<template lang="pug">
  .edit-product-panel(:class="bgClass")
    .nav
      ProductThumbnail(:product="product")
      ProductTitle(:product="product")
      .tabs
        router-link.tab(to="/publisher/new/title")
          i.las.la-tag
          span Title & Category
        router-link.tab(to="/publisher/new/media")
          i.las.la-photo-video
          span Images & Video
        router-link.tab(to="/publisher/new/texts")
          i.las.la-align-left
          span Instructions
        router-link.tab.selected(to="/publisher/new/files")
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
  methods: {
    doNext () {
      switch (this.$route.fullPath.split('/').slice(-1)[0]) {
        case 'title':
          this.saveTitle()
          this.$router.push('/publisher/new/media')
          break
        case 'media':
          this.saveMedia()
          this.$router.push('/publisher/new/texts')
          break
        case 'texts':
          this.saveTexts()
          this.$router.push('/publisher/new/files')
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
    },
    saveTexts () {
      console.log('SAVE TEXTS')
    },
    saveFiles () {
      console.log('SAVE FILES')
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
