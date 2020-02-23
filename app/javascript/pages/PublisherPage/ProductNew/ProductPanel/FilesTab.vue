<template lang="pug">
  .form
    VersionCreate
    Version(v-for="version in product.versions" :version="version")
</template>

<script>
import VersionCreate from "./VersionCreate.vue"
import Version       from "./Version.vue"

export default {
  components: {
    VersionCreate,
    Version,
  },
  data () {
    return {
      
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
  }
}
</script>

<style lsng="scss" scoped>
</style>
