<template lang='pug'>
  .top-board.flex.flex-col.items-center.w-full
    h1 Publisher Portal
    ul.separated
      li {{ user.name }}
      li {{ user.email }}
      li: a(href='/') Publisher settings
    .new-product
      a.w-56.long-button.red-bg(href='/') New product
    .earn-money &nbsp;
</template>

<script>
export default {
  data: function () {
    return {
      user: {
        name: 'User Name',
        email: 'email@dot.com'
      }
    }
  }
}
</script>

<style lang="scss">
  ul.separated li {
    @apply .inline .mr-2;
    & + li {
      @apply .pl-3;
      border-left: 1px solid hsla(0,0,100,0.2);
    }
  }
</style>
