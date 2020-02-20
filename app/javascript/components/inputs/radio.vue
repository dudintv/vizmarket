<template lang="pug">
  .form-field
    ul.radios
      li(
        v-for="(option, index) in options" 
        :data-index="index" 
        :key="index" 
        :class="{selected: option==value}"
        @click="$emit('input', option)"
      )
        label
          input.hidden(:name="name" type="radio" :value="option" v-model="value")
          i
          span {{ option }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
</template>

<script>
export default {
  props: {
    name: String,
    value: String,
    options: Array,
  },
}
</script>

<style scoped lang="scss">
  @import "../../css/common/colors";

  ul.radios {
    @apply flex flex-wrap w-full uppercase;
    background-color: $blue-10;

    li {
      @apply flex items-center justify-center h-16;

      &:hover {
        @apply bg-blue-20;
      }

      &.selected {
        @apply bg-body-darker;
      }

      label {
        @apply w-full h-full pl-4 pr-6 cursor-pointer flex items-center;
      }

      input + i::before {
        @apply text-4xl mr-1;
        // @extend .lar;
        // @extend .la-circle;
        font-family: 'Line Awesome Free';
        font-weight: 900;
        font-style: normal;
        font-variant: normal;
        content: "\f111"
      }

      input:checked + i::before {
        // @extend .las;
        // @extend .la-check-circle;
        content: "\f058";
        color: $blue;
      }

      input:checked ~ span {
        color: $blue;
      }
    }
  }
</style>
