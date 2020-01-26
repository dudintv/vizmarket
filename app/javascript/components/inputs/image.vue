<template lang="pug">
  .form-field
    PictureInput(
      width="230"
      height="230"
      removable=true
      @change="imageChange"
      :prefill="value"
    )
    .tip(v-if="$slots['tip']")
      slot(name="tip")
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
  },
  methods: {
    imageChange: function(image) { this.$emit('input', image) }
  },
}
</script>

<style lang="scss">
</style>
