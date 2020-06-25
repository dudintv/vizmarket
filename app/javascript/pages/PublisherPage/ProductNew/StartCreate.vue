<template lang="pug">
  .start-create-new-product.p-4
    h3 Choose type and name to begin
    form
      RadioInput(name="Type" v-model="kind" :options="kinds" :class="{'field_with_errors': triedToSend && errors.kind !== ''}")
      TextInput.w-full(name="New product name" v-model="name" :class="{'field_with_errors': triedToSend && errors.name !== ''}")
      ul#error_explanation(v-if="triedToSend && hasError")
        li(v-for="error in errors" v-if="error !== ''") {{ error }}
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
      triedToSend: false,
      errors: {
        kind: '',
        name: '',
      }
    }
  },
  methods: {
    createProduct () {
      this.triedToSend = true
      this.validateInput()
      if (this.hasError) {
        this.$backend.products.create({ name: this.name, kind: this.kind })
          .then(response => {
            if (response.status === 201) {
              console.log('!! response', response)
            }
          })
          .catch(error => {
            console.log('!! error', error)
          }) 
      }
    },
    validateInput () {
      this.errors.kind = this.kind.trim() === '' ? 'Please choose the kind to continue' : ''
      this.errors.name = this.name.trim() === '' ? 'Please enter the name to continue' : ''
    }
  },
  computed: {
    hasError () {
      return (this.errors.kind !== '' || this.errors.name !== '')
    }
  },
  watch: {
    kind() { this.validateInput() },
    name() { this.validateInput() },
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
