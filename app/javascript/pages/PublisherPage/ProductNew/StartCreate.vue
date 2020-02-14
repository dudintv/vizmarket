<template lang="pug">
  .start-create-new-product.w-64.mx-auto
    TextInput.w-full(name="Product name" v-model="name")
    a.w-full.long-button.red-bg(href='#' @click.prevent="createProduct") Create new product
</template>

<script>
import TextInput from "components/inputs/text.vue"

export default {
  components: {
    TextInput,
  },
  data: function () {
    return {
      name: "",
    }
  },
  methods: {
    createProduct: function() {

    }
  }
}
</script>

<style lsng="scss" scoped>
</style>
