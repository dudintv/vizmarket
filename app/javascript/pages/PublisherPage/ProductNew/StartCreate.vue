<template lang="pug">
  .start-create-new-product.p-4
    h3 Choose type and name to begin
    form
      RadioInput(name="Type" v-model="kind" :options="kinds" :class="{'field_with_errors': triedToSend && !$v.kind.required}")
      TextInput.w-full(name="New product name" v-model="name" :class="{'field_with_errors': triedToSend && !$v.name.minLength}")
      .error_explanation(v-if="triedToSend")
        ul
          li(v-for="error in $v.$iter") {{ error }}
      button.w-full.bg-red-grad-x.hover--bg-red-grad-x-hover.p-4.uppercase(@click.prevent="createProduct") Create new product
</template>

<script>
import RadioInput from "components/inputs/radio.vue"
import TextInput from "components/inputs/text.vue"
import { required, minLength } from 'vuelidate/lib/validators'

export default {
  components: {
    RadioInput,
    TextInput,
  },
  data () {
    return {
      kinds: ['script', 'scene', 'plugin'],
      kind: '',
      name: '',
      triedToSend: false,
    }
  },
  methods: {
    createProduct () {
      console.log('$v.$params', this.$v.$params)
      this.triedToSend = true
      this.$v.$touch()
      if (this.$v.$anyError) {
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
    // validateInput () {
    //   this.errors.kind = this.kind.trim() === '' ? 'Please choose the kind to continue' : ''
    //   this.errors.name = this.name.trim() === '' ? 'Please enter the name to continue' : ''
    // }
  },
  // computed: {
  //   hasError () {
  //     return (this.errors.kind !== '' || this.errors.name !== '')
  //   }
  // },
  // watch: {
  //   kind() { this.validateInput() },
  //   name() { this.validateInput() },
  // }
  validations: {
    kind: {
      required,
    },
    name: {
      required,
      minLength: minLength(3),
    }
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
