<template lang="pug">
  .start-create-new-product.p-4
    h3.mb-4 Choose type and name to begin
    form(@submit.prevent="createProduct")
      RadioInput(name="Type" v-model="kind" :options="kinds" :class="{'has_error': $v.kind.$error}")
        template(#error v-if="$v.kind.$error") Select Type to continue
      TextInput.w-full(name="New product name" v-model="name" :class="{'has_error': $v.name.$error}" autocomplete="off")
        template(#error v-if="$v.name.$error && !$v.name.required") Name is required
        template(#error v-else-if="$v.name.$error && !$v.name.minLength") Name must have at least {{ $v.name.$params.minLength.min }} letters
      button.w-full.bg-red-grad-x.hover--bg-red-grad-x-hover.p-4.uppercase(type="submit") Create new product
      .error_explanation(v-if="errorFromServer!==''") {{ errorFromServer }}
</template>

<script>
import RadioInput from 'components/inputs/radio.vue'
import TextInput from 'components/inputs/text.vue'
import { required, minLength } from 'vuelidate/lib/validators'

export default {
  components: {
    RadioInput,
    TextInput,
  },
  data () {
    return {
      kinds: ['script', 'scene', 'plugin', 'asset'],
      kind: '',
      name: '',
      errorFromServer: '',
    }
  },
  validations: {
    kind: {
      required,
    },
    name: {
      required,
      minLength: minLength(3),
    }
  },
  methods: {
    createProduct () {
      this.$v.$touch()
      if (!this.$v.$error) {
        this.$backend.products.create({ name: this.name, kind: this.kind })
          .then(response => {
            if (response.status === 201) {
              FlashVM.notice('The draft of new product was succesfully created')
              this.$store.commit('setCurrentProduct', response.data.data.attributes)
              this.$router.push({path: `/publisher/products/${response.data.data.id}/title`})
            }
          })
          .catch(error => {
            console.warn('Can\'t create product. Error:', error)
            this.errorFromServer = error
            FlashVM.alert(error.message)
          }) 
      }
    },
  },
}
</script>

<style lang="scss" scoped>
  .start-create-new-product {
    width: 50vw;
    min-width: 30rem;
    max-width: 40rem;
  }
</style>
