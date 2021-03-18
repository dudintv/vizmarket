<template lang='pug'>
  #test-page
    .bg-white-05.w-full.p-2.flex
      span.pr-4 Test pages:
      router-link.px-2(to="/test/colors") Colors
      router-link.px-2(to="/test/inputs") Inputs
    router-view
</template>

<script>
export default {
}
</script>

<style scoped>
  .router-link-exact-active {
    font-weight: bold;
    text-decoration: underline;
  }
</style>