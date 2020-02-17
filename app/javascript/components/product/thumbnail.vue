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
      default: function () { return {
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
      @apply block px-2 relative;

      &:not(:last-child){
        @apply pr-4;
      }

      &:last-child {
        @apply pr-2;
      }

      &::before{
        content: '';
        position: absolute;
        width: .6rem;
        height: 100%;
        left: -.6rem;
        border-left: .6rem solid transparent;
      }

      &.featured{
        // background: $red-grad-x;
        background: var(--color-red-grad-x);
        
        &::before{
          @apply border-orange;
          border-left-color: transparent;
          border-bottom-width: 1.5rem;
        }
      }
      
      &.new{
        // background: $green-grad-x;
        background: var(--color-green-grad-x);

        &::before{
          @apply border-lime;
          border-left-color: transparent;
          border-bottom-width: 1.5rem;
        }
      }
    }
  }
</style>
