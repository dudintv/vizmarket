<template lang="pug">
  .form-field
    PictureInput(
      :name="inputName"
      :width="width"
      :height="height"
      removable=true
      @change="imageChange"
      @remove="imageRemove"
      :prefill="value"
      :recommendations="recommendations"
      :isLoading="isLoading"
      :successMessage="successMessage"
      :errorMessage="errorMessage"
    )
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
import PictureInput from './sources/VuePictureInput.vue'

export default {
  components: {
    PictureInput
  },
  data () {
    return {
      height: 230,
    }
  },
  props: {
    name: String,
    value: [String, File],
    recommendations: String,
    aspect: {
      type: Number,
      default: 1,
    },
    isLoading: {
      type: Boolean,
      default: false,
    },
    successMessage: {
      type: String,
      default: undefined,
    },
    errorMessage: {
      type: String,
      default: undefined,
    },
  },
  computed: {
    inputName () {
      return this.name?.toLowerCase().replace(/\s/g, '_')
    },
    width () {
      return this.height * this.aspect
    },
  },
  methods: {
    imageChange: function(image) { this.$emit('input', image) },
    imageRemove: function() { this.$emit('input', null) },
  },
}
</script>

<style lang="scss">
</style>
