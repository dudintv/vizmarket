<template lang="pug">
  .products-list
    TopBoard
    .products(v-if="filteredAndSortedAndGroupedProducts")
      ProductsFilter.my-6
      ProductItem(v-for="product in filteredAndSortedAndGroupedProducts" :product="product" :key="product.id")
    .empty-products(v-else).flex.justify-center.items-center.text-white-20.w-full.h-64
      .block
        h5.text-center No products
        p.text-20 You are welcome to add new one
</template>

<script>
import TopBoard from './TopBoard'
import ProductsFilter from './Filter';
import ProductItem from './Item';

export default {
  components: {
    TopBoard,
    ProductsFilter,
    ProductItem,
  },
  computed: {
    filteredAndSortedAndGroupedProducts () { return this.$store.getters.filteredAndSortedAndGroupedProducts },
  },
  async created () {
    await this.$store.dispatch('loadCurrentUser')
    // await this.$store.dispatch('loadProducts') // moved to beforeRouteEnter()
  },
  mounted () {
    this.$store.dispatch('loadTaxonomy')
  },
  beforeRouteEnter (to, from, next) {
    next(vm => {
      vm.$store.dispatch('loadProducts')
    })
  },
}
</script>
