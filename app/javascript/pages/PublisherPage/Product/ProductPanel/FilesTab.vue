<template lang="pug">
  .form
    VersionCreate
    VersionShow(v-for="version in product.versions" :version="version" :key="version.id")
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
      
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
  },
}
</script>

<style lsng="scss" scoped>
</style>
