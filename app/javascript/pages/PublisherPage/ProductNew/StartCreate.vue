<template lang="pug">
  .start-create-new-product.p-4
    h3 Choose type and name to begin
    form
      RadioInput(name="Type" v-model="kind" :options="kinds")
      TextInput.w-full(name="New product name" v-model="name" :class="{'field_with_errors': hasError}")
      #error_explanation(v-if="hasError") {{ error }}
      button.w-full.bg-red-grad-x.hover--bg-red-grad-x-hover.p-4.uppercase(@click.prevent="createProduct") Create new product
</template>

<script>
import RadioInput from "components/inputs/radio.vue"
import TextInput from "components/inputs/text.vue"

export default {
  components: {
    RadioInput,
    TextInput,
  },
  data () {
    return {
      name: '',
      kind: '',
      kinds: ['script', 'scene', 'plugin'],
      hasError: false,
      error: ''
    }
  },
  methods: {
    createProduct () {
      if (this.name.trim() !== '' && this.kind.trim() !== '') {
        this.hasError = false
        this.$backend.products.create({ name: this.name, kind: this.kind })
          .then(response => {
            if (response.status === 201) {
              console.log('!! response', response)
            }
          })
          .catch(error => {
            console.log('!! error', error)
          })
      } else {
        this.hasError = true
        this.checkInput()
      }
    },
    checkInput() {
      if (this.hasError) {
        if (this.name.trim() === '') { this.error = 'Please enter the name to continue' }
        if (this.kind.trim() === '') { this.error = 'Please choose the kind to continue' }
        if (this.name.trim() !== '' && this.kind.trim() !== '') { this.hasError = false }
      }
    }
  },
  watch: {
    name () { this.checkInput() },
    kind () { this.checkInput() },
  }
}
</script>

<style lang="scss" scoped>
  .start-create-new-product {
    width: 50vw;
    min-width: 30rem;
    max-width: 40rem;
  }
</style>
