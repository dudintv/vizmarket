<template lang='pug'>
  .top-board.flex.flex-col.items-center.w-full
    h1.mb-0 Publisher Portal

    div(v-if="isAuthorLoading")
      | loading ...
    ul.separated.mb-2(v-else)
      li {{ author.name }}
      li {{ author.title }}
      li: a(href='/publisher/author') Publisher settings
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
      isShowNewProductDialog: false,
    }
  },
  computed: {
    isAuthorLoading () {
      console.log('this.author = ', this.author)
      if (!this.author) return true
      return Object.getOwnPropertyNames(this.author).length === 0
    },
    user () {
      return this.$store.state.currentUser
    },
    author () {
      return this.$store.state.currentAuthor
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
