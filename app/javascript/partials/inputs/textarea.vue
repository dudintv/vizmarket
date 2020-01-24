<template lang="pug">
  .form-field
    .field-with-label
      textarea(ref="textarea" :name="name" :id="name" :value="value" @input="$emit('input', $event.target.value);textareaAutoGrowth();" placeholder=" ")
      label(:for="name"): .input-name {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
</template>

<script>
export default {
  props: {
    name: String,
    value: String,
  },
  methods: {
    textareaAutoGrowth() {
      let el = this.$refs.textarea;
      el.style.height = (el.scrollHeight)+"px";
    }
  }
}
</script>

<style scoped lang="scss">
</style>
