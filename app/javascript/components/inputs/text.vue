<template lang="pug">
  .form-field
    .field-with-label
      input(
        :type="inputType"
        :name="name"
        :id="inputId"
        :value="value"
        @input="$emit('input', $event.target.value)"
        :placeholder="placeholder"
        :autocomplete="autocomplete"
        :required="required"
        )
      label(:for="name"): .input-name {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
export default {
  props: {
    id: String,
    name: String,
    type: String,
    value: String,
    autocomplete: {
      type: String,
      default: "on"
    },
    placeholder: {
      type: String,
      default: " ",
    },
    required: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    inputId () {
      return this.id ?? this.name
    },
    inputType () {
      return this.type ?? 'text'
    },
  }
}
</script>
