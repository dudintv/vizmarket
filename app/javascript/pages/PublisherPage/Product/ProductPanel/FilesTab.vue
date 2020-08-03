<template lang="pug">
  .form
    div(v-for="version in product.versions" :key="version.id")
      VersionForm(v-if="version.isEdit" :version="version" @hide="hideEditingPanel(version)")
      VersionListItem(v-else :version="version")
    VersionForm(v-if="isShowCreateVersionPanel" @hide="hideCreatingPanel()" isCreating)
    button.btn.main-btn.middle-btn.mb-4(v-else @click="isShowCreateVersionPanel=true") Create new version
</template>

<script>
import VersionForm from "./Version/Form.vue"
import VersionListItem from "./Version/ListItem.vue"

export default {
  components: {
    VersionForm,
    VersionListItem,
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
    },
    hideEditingPanel (version) {
      version.isEdit = false
    }
  }
}
</script>

<style lsng="scss" scoped>
</style>
