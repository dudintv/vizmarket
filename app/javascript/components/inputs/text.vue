<template lang="pug">
  .form-field
    .field-with-label
      input(type="text" :name="name" :id="name" :value="value" @input="$emit('input', $event.target.value)" :placeholder="placeholder" :autocomplete="autocomplete")
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
    autocomplete: {
      type: String,
      default: "on"
    },
    placeholder: {
      type: String,
      default: " ",
    }
  },
}
</script>
