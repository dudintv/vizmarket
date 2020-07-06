<template lang='pug'>
  .top-board.flex.flex-col.items-center.w-full
    h1.mb-0 Publisher Portal
    ul.separated.mb-2
      li {{ user.name }}
      li {{ user.email }}
      li: a(href='/') Publisher settings
    .new-product
      button.big-btn.main-btn(@click="isShowNewProductDialog=true") New product
      ModalWindow(v-model="isShowNewProductDialog")
        StartCreate
</template>

<script>
import ModalWindow from "components/common/ModalWindow"
import StartCreate from "../Product/StartCreate"

export default {
  components: {
    ModalWindow,
    StartCreate,
  },
  data () {
    return {
      user: {
        name: 'User Name',
        email: 'email@dot.com'
      },
      isShowNewProductDialog: false,
    }
  }
}
</script>

<style lang="scss" scoped>
  ul.separated li {
    @apply inline mr-2;
    & + li {
      @apply pl-3 border-l border-white-20;
    }
  }
</style>
