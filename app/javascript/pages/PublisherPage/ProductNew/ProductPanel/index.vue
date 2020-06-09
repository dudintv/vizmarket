<template lang="pug">
  .edit-product-panel(:class="bg_class")
    .nav
      ProductThumbnail(:product="product")
      ProductTitle(:product="product")
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
        a.tab.selected(href="#")
          i.las.la-file-upload
          span Product files
    .content
      component(is="ProductMediaTab")
    .status
      span.text-white-20 status:&nbsp;
      span {{ product.status }}
    .actions
      button.big-btn.third-btn Delete the draft
      button.big-btn.second-btn Save and continue later
      button.big-btn.main-btn Next: upload files
</template>

<script>
import ProductThumbnail from 'components/product/thumbnail'
import ProductTitle from 'components/product/title'

import ProductTitleTab from './TitleTab'
import ProductMediaTab from './MediaTab'
import ProductTextsTab from './TextsTab'
import ProductFilesTab from './FilesTab'

export default {
  components: {
    ProductThumbnail,
    ProductTitle,
    ProductTitleTab,
    ProductMediaTab,
    ProductTextsTab,
    ProductFilesTab,
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
    bg_class () {
      return this.product.status == 'published' ? 'bg-published' : 'bg-unpublished'
    }
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

      &.selected {
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
