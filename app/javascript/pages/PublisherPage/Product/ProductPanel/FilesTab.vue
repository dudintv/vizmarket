<template lang="pug">
  .form
    div(v-for="version in product.versions" :key="version.id")
      VersionForm(v-if="version.isEdit" :version="version" @hide="hideEditingPanel(version)")
      VersionListItem(v-else :version="version")
    VersionForm(v-if="isShowCreateVersionPanel" @hide="hideCreatingPanel()" :recommendedNewNumber="recommendedNewNumber" isCreating)
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
    recommendedNewNumber () {
      if (this.product.versions.length > 0) {
        const majorVer = this.product.versions.slice(-1)[0].number ?? 1
        return `${Number(majorVer) + 1}`
        // return "9.99"
      } else {
        return "1.0"
      }
    }
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
