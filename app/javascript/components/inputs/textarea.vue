<template lang="pug">
  .form-field
    .field-with-label
      textarea(
        ref="textarea" 
        :name="name" 
        :id="name" 
        :value="value" 
        @input="$emit('input', $event.target.value); textareaAutoGrowth();"
        placeholder=" "
        :style="`max-height: ${maxHeightCss}`")
      label(:for="name"): .input-name {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
export default {
  props: {
    name: String,
    value: String,
    maxHeightCss: String,
  },
  methods: {
    textareaAutoGrowth () {
      let el = this.$refs.textarea;
      el.style.height = (el.scrollHeight)+"px";
    }
  }
}
</script>

<style scoped lang="scss">
</style>
