<template lang="pug">
  .start-create-new-product.w-128.p-4
    h3 Type name to begin
    form
      TextInput.w-full(name="New product name" v-model="name" :class="{'field_with_errors': hasError}")
      #error_explanation(v-if="hasError") Please enter the name to continue
      button.w-full.bg-red-grad-x.hover--bg-red-grad-x-hover.p-4(@click.prevent="createProduct") Create new product
</template>

<script>
import TextInput from "components/inputs/text.vue"

export default {
  components: {
    TextInput,
  },
  data () {
    return {
      name: "",
      hasError: false,
    }
  },
  methods: {
    createProduct () {
      if (this.name.trim() === '') {
        this.hasError = true
      } else {
        this.hasError = false
        this.$backend.products.create(this.name)
      }
    }
  },
  watch: {
    name (newName) {
      if ( newName.trim() !== '') this.hasError = false
    }
  }
}
</script>
