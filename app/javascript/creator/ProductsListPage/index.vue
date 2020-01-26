<template lang="pug">
  .products-list
    TopBoard
    .products
      ProductsFilter.my-6
      ProductItem(v-for="product in products" :product="product" :key="product.id")
</template>

<script>
import TopBoard from './TopBoard'
import ProductsFilter from './filter';
import ProductItem from './item';

export default {
  components: {
    TopBoard,
    ProductsFilter,
    ProductItem,
  },
  data: function() {
    return {
      products: [
        {
          id: 1,
          cover: null,
          title: 'Random movement',
          short_description: 'Random besier movement single container with separated three dimensions.',
          created_at: '2019-12-31 02:09:38 UTC',
          updated_at: '2020-01-03 03:57:14 UTC',
          public: true,
          featured: false,
          kind: 'Script',
          category: 'Positioning',
          price: 100,
          price_original: 200,
          purchased_count: 14,
          rating: {
            average: 4.7,
            count: 35,
          },
          versions: [
            {
              number: 1.2,
              created_at: '2020-01-03 03:57:14 UTC',
              developed_for: 'developed for VizArtist 3.10 … 3.13',
              // tested_in: 'tested in VizArtist 3.13',
            },
            {
              number: 1.1,
              created_at: '2020-01-02 02:34:00 UTC',
              developed_for: 'developed for VizArtist 3.10',
              // tested_in: 'tested in VizArtist 3.10',
            },
            {
              number: 1.0,
              created_at: '2020-01-01 01:00:00 UTC',
              developed_for: 'developed for VizArtist 3.8',
              // tested_in: 'tested in VizArtist 3.8',
            },
          ]
        }
      ]
    }
  },
}
</script>

<style>

</style>
