<template lang="pug">
  .form-field
    VueFilesDropper(
      :inputId="inputId"
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
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
import VueFilesDropper from "./sources/VueFilesDropper.vue";

export default {
  components: {
    VueFilesDropper,
  },
  props: {
    inputId: String,
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
