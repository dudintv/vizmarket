<template lang="pug">
  .form-field
    .field-with-label.price
      input(type="number" min="0" :name="name" :id="name" :value="value" @input="$emit('input', $event.target.value)")
      label(:for="name"): .input-name {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
export default {
  props: {
    name: String,
    value: Number,
  },
}
</script>

<style scoped lang="scss">
  .price{
    @apply w-32 relative;

    &::after {
      @apply absolute bottom-3 left-4 text-blue pointer-events-none;
      content: "$";
    }

    input[type="number"] {
      @apply text-right;

    }

    input[type="number"]::-webkit-inner-spin-button { 
      display: none;
    }
  }
</style>
