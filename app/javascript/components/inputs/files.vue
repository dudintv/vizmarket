<template lang="pug">
  .form-field
    VueFilesDropper(
      v-model="files"
      multiple
    )
      div(v-if="!value.length") 
        p Drag files or click here
      div(v-else)
        span(v-if="value.length==1") You added a file:
        span(v-if="value.length>1") You added {{value.length}} files:
        div(v-for="(file, index) in this.value" :key="index")
          i.las.la-file
          span {{file.name}}

    .tip(v-if="$slots['tip']")
      slot(name="tip")
</template>

<script>
import VueFilesDropper from "./sources/VueFilesDropper.vue";

export default {
  components: {
    VueFilesDropper,
  },
  props: {
    name: String,
    value: Array,
  },
  data () {
    return {
      files: [],
    }
  },
  watch: {
    files () { this.$emit('input', this.files) }
  },
  mounted () { this.files = this.value }
}
</script>

<style scoped lang="scss">
</style>
