<template lang="pug">
  .product-title
    .taxonomy(v-if="product.kind || product.category")
      a.kind {{ product.kind }}&nbsp;
      a.category / {{ product.category }}
    span.title {{ product.title }}
</template>

<script>
export default {
  props: {
    product: Object,
  }
}
</script>

<style lang="scss" scoped>
  .product-title {
    @apply block px-4 py-2 bg-item;
  }

  .kind {
    @apply text-base uppercase font-semibold text-orange;
  }

  .category {
    @apply text-base capitalize text-light-blue;
  }

  .title {
    @apply text-2xl font-semibold;
  }
</style>