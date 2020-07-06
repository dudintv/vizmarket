<template lang="pug">
  .products-list
    TopBoard
    .products(v-if="filteredProducts")
      ProductsFilter.my-6
      ProductItem(v-for="product in filteredProducts" :product="product" :key="product.id")
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
    filteredProducts () { return this.$store.getters.filteredProducts },
  }
}
</script>
