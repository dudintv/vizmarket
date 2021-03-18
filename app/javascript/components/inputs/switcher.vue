<template lang="pug">
  div(:class="{ 'form-field': isFormField }")
    .checkbox-field-with-label(@click="change()")
      span.name.off-name(v-if="off_name" :class="{ checked: !checked }") {{ off_name }}
      input.checkbox(type="checkbox" :name="name" :id="name" :checked="value" ref="checkbox")
      .border
        .loading(v-show="isLoading")
        .point
      span.name.on-name(:class="{ checked: checked }") {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
export default {
  props: {
    name: String,
    off_name: String,
    value: Boolean,
    isLoading: {
      type: Boolean,
      default: false,
    },
    isFormField: {
      type: Boolean,
      default: true,
    }
  },
  data() {
    return {
      checked: false,
    }
  },
  mounted () {
    this.checked = this.$refs.checkbox.checked;
  },
  methods: {
    change () {
      this.$refs.checkbox.checked = !this.$refs.checkbox.checked
      this.checked = this.$refs.checkbox.checked
      this.$emit('input', this.$refs.checkbox.checked)
    }
  },
}
</script>

<style scoped lang="scss">
  .checkbox-field-with-label {
    @apply flex items-center cursor-pointer;
  }

  .checkbox {
    @apply hidden;
  }

  .name {
    @apply text-white-50;

    &.checked {
      @apply text-white;
    }
  }

  .off-name {
    @apply mr-2;
  }

  .border {
    @apply relative overflow-hidden flex justify-center items-center h-8 w-16 border border-white-50 rounded-full bg-white-10 px-1 mr-2;
    transition: background-color .2s cubic-bezier(0.77, 0, 0.175, 1); //easeInOutQuart

    &:first-child {
      margin-left: -1rem;
    }

    .point {
      @apply rounded-full bg-white;
      height: 1.4rem;
      width: 1.4rem;
      transition: transform .2s cubic-bezier(0.68, -0.55, 0.265, 1.55); //easeInOutBack
    }

    .checkbox + & {
      .point {
        transform: translateX(-1rem);
      }
    }

    .checkbox:checked + & {
      @apply bg-red;
      .point {
        transform: translateX(1rem);
      }
    }
  }

  // @keyframes barberpole {
  //   from { background-position-x: 0; }
  //   to   { background-position-x: 4rem; }
  // }
  // .loading {
  //   @apply bg-loading;
  //   animation: barberpole 1s linear infinite;
  // }

  .tip {
    @apply pl-0;
  }
</style>
