<template lang="pug">
  .form
    VersionShow(v-for="version in product.versions" :version="version" :key="version.id")
    VersionCreate(v-if="isShowCreateVersionPanel" @hide="hideCreatingPanel()")
    button.btn.main-btn.middle-btn.mb-4(v-else @click="isShowCreateVersionPanel=true") Create new version
</template>

<script>
import VersionCreate from "./Version/Create.vue"
import VersionShow   from "./Version/Show.vue"

export default {
  components: {
    VersionCreate,
    VersionShow,
  },
  data () {
    return {
      isShowCreateVersionPanel: false,
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
  },
  methods: {
    hideCreatingPanel () {
      this.isShowCreateVersionPanel = false
    }
  }
}
</script>

<style lsng="scss" scoped>
</style>
