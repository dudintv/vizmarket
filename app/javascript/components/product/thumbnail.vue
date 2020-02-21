<template lang="pug">
  .product-thumbnail
    img(v-if="!product.image" src='/images/svg/default-product.svg')
    img(v-else :src="product.image")
    .labels
      .label.uppercase(v-for="label in product.labels" :class="label.toLowerCase()") {{ label }}
</template>

<script>
export default {
  props: {
    product: {
      type: Object,
      default () { return {
          image: '',
          labels: [],
      }}
    },
  }
}
</script>

<style lang="scss" scoped>
  .product-thumbnail{
    @apply relative;
  }

  .labels {
    @apply flex absolute bottom-0 right-0;

    .label {
      @apply flex pl-2 relative text-sm h-6 items-center;

      &:not(:last-child){
        @apply pr-6;
      }

      &:last-child {
        @apply pr-3;
      }

      &::before{
        content: '';
        position: absolute;
        width: 1rem;
        height: 100%;
        left: -1rem;
        border-left: 1rem solid transparent;
      }

      &.featured{
        @apply bg-red-grad-x;
        
        &::before{
          @apply border-orange;
          border-left-color: transparent;
          border-bottom-width: 1.5rem;
        }
      }
      
      &.new{
        @apply bg-green-grad-x;

        &::before{
          @apply border-lime;
          border-left-color: transparent;
          border-bottom-width: 1.5rem;
        }
      }
    }
  }
</style>
