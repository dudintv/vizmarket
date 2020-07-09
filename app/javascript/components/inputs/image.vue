<template lang="pug">
  .form-field
    PictureInput(
      :name="inputName"
      width="230"
      height="230"
      removable=true
      @change="imageChange"
      @remove="imageRemove"
      :prefill="value"
      :recommendations="recommendations"
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
  props: {
    name: String,
    value: [String, File],
    recommendations: String,
  },
  computed: {
    inputName () {
      return this.name.toLowerCase().replace(/\s/g, '_')
    }
  },
  methods: {
    imageChange: function(image) { this.$emit('input', image) },
    imageRemove: function() { this.$emit('input', null) },
  },
}
</script>

<style lang="scss">
</style>
