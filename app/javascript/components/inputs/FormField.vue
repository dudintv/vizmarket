<template lang="pug">
  .field
    .about
      span.required(v-if="required") required
      h5
        | {{ title }}
        span.required-star(v-if="required") *
      p {{ description }}
    .control
      slot(name="input")
</template>

<script>
export default {
  props: {
    title: String,
    description: String,
    required: Boolean,
  },
}
</script>

<style lang="scss" scoped>
  .field {
    @apply mb-4;
    display: grid;
    grid-template-columns: auto;
    grid-column-gap: 1rem;
  }
  @media (min-width: 1100px) {
    .field {
      grid-template-columns: minmax(200px, 284px) auto;
    }
  }
  .about {
    @apply mb-4;
    
    .required {
      @apply block uppercase text-white-50 text-sm;
      margin-top: -3px;
      margin-bottom: -3px;
    }

    .required-star {
      @apply text-red;
    }

    h5{
      @apply mb-1;
    }

    p {
      @apply text-white-80;
    }
  }
</style>
