<template lang="pug">
  .form-field
    .checkbox-field-with-label(@click="change()")
      span.name.off-name(v-if="off_name" :class="{ checked: !checked }") {{ off_name }}
      input.checkbox(type="checkbox" :name="name" :id="name" :checked="value" ref="checkbox")
      .border(:class="{ loading: loading }")
        .point
      span.name.on-name(:class="{ checked: checked }") {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
</template>

<script>
export default {
  props: {
    name: String,
    off_name: String,
    value: Boolean,
    loading: {
      type: Boolean,
      default: false,
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
    @apply flex justify-center items-center h-8 w-16 border border-white-50 rounded-full bg-white-10 px-1 mr-2;
    transition: background-color .2s cubic-bezier(0.77, 0, 0.175, 1); //easeInOutQuart

    &:first-child {
      margin-left: -1rem;
    }

    .point {
      @apply h-6 w-6 rounded-full bg-white;
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

  @keyframes barberpole {
    from { background-position-x: 0; }
    to   { background-position-x: 4rem; }
  }
  .loading {
    background: repeating-linear-gradient(
      45deg,
      theme('colors.orange'),
      theme('colors.orange') 11%,
      transparent 11%,
      transparent 22%
    );
    animation: barberpole 1s linear infinite;
  }

  .tip {
    @apply pl-0;
  }
</style>
