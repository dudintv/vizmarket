<template lang='pug'>
  .creator
    TopBoard
    ProductsFilter
    ProductsList
</template>

<script>
import TopBoard from './top-board.vue';
import ProductsFilter from './products/filter.vue';
import ProductsList from './products/index.vue';

export default {
  components: {
    TopBoard, 
    ProductsFilter, 
    ProductsList,
  },
}
</script>

<style>

</style>
