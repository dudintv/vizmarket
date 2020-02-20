<template lang="pug">
  .edit-product-panel
    .nav
      ProductThumbnail(:product="product")
      h5.title {{ product.title }}
      .tabs
        a.tab(href="#")
          i.las.la-tag
          span Title & Category
        a.tab(href="#")
          i.las.la-photo-video
          span Images & Video
        a.tab(href="#")
          i.las.la-align-left
          span Instructions
        a.tab(href="#")
          i.las.la-file-upload
          span Product files
    .content
      component(is="ProductTitleTab")
    .status
    .actions
</template>

<script>
import ProductThumbnail from 'components/product/thumbnail'
import ProductTitleTab from './TitleTab'
import ProductMediaTab from './MediaTab'
import ProductTextsTab from './TextsTab'
import ProductFilesTab from './FilesTab'

export default {
  components: {
    ProductThumbnail,
    ProductTitleTab,
    ProductMediaTab,
    ProductTextsTab,
    ProductFilesTab,
  },
  computed: {
    product: function () {
      return this.$store.state.currentProduct;
    }
  }
}
</script>

<style style="scss" scoped>
  .edit-product-panel {
    @apply bg-item;
    display: grid;
    grid-template-columns: 284px auto;
    grid-template-rows: auto 100px;
    grid-template-areas: 
      "nav content"
      "status actions";
  }

  .nav {
    grid-area: nav;
    /* background-color: red; */

    .title {
      @apply px-4 py-2 bg-item-darker;
    }

    .tabs {
      @apply bg-item-lighter;
    }

    .tab {
      @apply block p-4 text-xl;

      i {
        @apply mr-6;
      }

      &:hover {
        @apply bg-white-05;
      }
    }
  }

  .content {
    grid-area: content;
    /* background-color: green; */
  }

  .status {
    grid-area: status;
    /* background-color: blue; */
  }

  .actions {
    grid-area: actions;
    /* background-color: yellow; */
  }
</style>
