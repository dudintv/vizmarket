<template lang="pug">
  .edit-product-panel
    .epp-nav
      .epp-preview
        ProductThumbnail
      .epp-menu
    .epp-content
      component(is="ProductTitleTab")
    .epp-status
    .epp-actions
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
}
</script>

<style style="scss" scoped>
  .edit-product-panel {
    display: grid;
    grid-template-columns: 284px auto;
    grid-template-rows: auto 100px;
    grid-template-areas: 
      "nav content"
      "status actions";
  }

  .epp-nav {
    grid-area: nav;
    background-color: red;
  }

  .epp-content {
    grid-area: content;
    background-color: green;
  }

  .epp-status {
    grid-area: status;
    background-color: blue;
  }

  .epp-actions {
    grid-area: actions;
    background-color: yellow;
  }
</style>
