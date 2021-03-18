<template lang="pug">
  .stepper
    router-link.step(
      v-for="(step, index) in steps" 
      :key="index"
      :class="{ invalid: !!step.invalid, done: !!step.done }"
      :to="step.link"
      )
      span.number {{ step.name }}
      span.title {{ step.title }}
</template>

<script>
export default {
  props: {
    steps: {
      type: Array,
      default: [
        {
          name: 1,
          title: 'First item',
          valid: undefined,
          done: false,
        }
      ],
    },
  }
}
</script>

<style lang="scss" scoped>
  .stepper {
    @apply flex justify-center;
  }

  .step {
    @apply relative border border-orange text-center px-2 mr-6 cursor-pointer;
    min-width: 2rem;
    height: 2rem;
    border-radius: 1rem;
    line-height: 1.8rem;

    .title {
      @apply inline-block opacity-0 absolute text-center pointer-events-none;
      width: 20rem;
      transform: translateX(-50%);
      top: 2rem;
      transition: opacity .3s linear;
    }

    &:hover {
      @apply bg-orange-hover;

      .title {
        @apply opacity-100;
        transition: opacity .1s linear;
      }
    }

    &.router-link-exact-active {
      @apply bg-orange shadow border-white;

      &:hover {
        @apply bg-orange-hover;
      }
    }

    &.done {
      @apply bg-orange;

      &:hover {
        @apply bg-orange-hover;
      }

      &.invalid {
        @apply bg-red border-red;

        &:hover {
          @apply bg-red-hover;
        }

        &::after {
          @apply absolute text-red;
          right: -.5rem;
          content: '!'
        }
      }
    }
  }

  
</style>
