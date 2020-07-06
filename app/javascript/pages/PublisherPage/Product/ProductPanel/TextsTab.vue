<template lang="pug">
  .form
    FormField(:required="true", title="Detailed description", description="Provide a full explanation of your product and set the expectations of what it can be used for. Must be 1900 characters or less.")
      template(#input): TextareaInput(name="Detailed description" v-model="product.description")
    FormField(:required="true", title="How to install and use", description="This text should provide all the discrete data that details the contents of your product and how it can be used. Links to any documentation or instructional material should appear here. Must be 1900 characters or less.")
      template(#input): TextareaInput(name="How to install and use" v-model="product.instruction")
</template>

<script>
import FormField     from "components/inputs/FormField.vue"
import TextareaInput from "components/inputs/textarea.vue"
export default {
  components: {
    FormField,
    TextareaInput,
  },
  computed: {
    product () {
      return this.$store.state.currentProduct
    },
  }
}
</script>
