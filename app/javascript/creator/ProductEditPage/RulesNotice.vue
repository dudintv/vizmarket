<template lang="pug">
  .rules-notice.w-full.flex.items-center.justify-center.relative.bottom-0.bg-cover.bg-center.border.border-item-darker.shadow-xl.p-8.my-4(
    :style="`background-image: url(${image})`"
  )
    .fade-background.absolute.w-full.h-full.top-0.left-0.bg-item-darker.opacity-75 &nbsp;
    p.rules-notice-content.z-10.text-center
      | Before continuing any further, please ensure that
      br
      | you have thoroughly reviewed the 
      a(href="#") Marketplace Guidelines.
</template>

<script>
export default {
  props: {
    image: String,
  }
}
</script>

<style lang="scss" scoped>
  .rules-notice {
    transition: box-shadow .3s ease, transform .3s ease;

    &:hover {
      @apply shadow-2xl;
      transform: translateY(-2px);
    }
  }

  a {
    @apply border-b border-white-20;

    &:hover {
      @apply border-white-50;
    }
  }
</style>
