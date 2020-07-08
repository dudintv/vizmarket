<template lang="pug">
  .form-field
    ImageLoader(
      :Images="images"
      multiple
      @input="updateInput"
      keyName="name"
      valueName="image"
    )
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
import ImageLoader from "./sources/VueImageLoader.vue";

export default {
  components: {
    ImageLoader,
  },
  props: {
    name: String,
    value: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      images: [],
    }
  },
  methods: {
    updateInput (newImageList) {
      this.$emit('input', newImageList)
    }
  },
  mounted () {
    this.images = this.value;
  }
}
</script>

<style>
</style>
