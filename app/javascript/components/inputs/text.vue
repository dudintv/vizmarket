<template lang="pug">
  .form-field
    .field-with-label
      input(type="text" :name="name" :id="name" :value="value" @input="$emit('input', $event.target.value)" placeholder=" ")
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
}
</script>

<style scoped lang="scss">
</style>
