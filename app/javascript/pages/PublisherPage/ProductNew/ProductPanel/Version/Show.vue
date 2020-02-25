<template lang="pug">
  .product-version
    table.versions-table
      tr
        td ver. {{ version.number }}
        td {{ dates }}
      tr
        td.text-white-50 Files:
        td: ul.files: li(v-for="file in version.files"): a.file(:href="file.path") {{ file.filename }}
      tr
        td.text-white-50 Support:
        td {{ version.support }}
</template>

<script>
export default {
  props: {
    version: Object,
  },
  computed: {
    dates () {
      const created_at = (new Date(this.version.created_at)).toLocaleDateString()

      if(!this.version.updated_at || this.version.created_at == this.version.updated_at) {
        return created_at
      } else {
        const updated_at = (new Date(this.version.created_at)).toLocaleDateString()
        return `${created_at} — ${updated_at}`
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .product-version {
    @apply bg-unpublished border border-white-05 shadow-md mb-8 p-6;
  }

  .versions-table{
    border-spacing: 20px 10px;
    border-collapse: separate;
  }

  .files li {
    @apply block;
  }
  .file {
    @apply text-orange;

    &:hover {
      @apply text-orange-hover border-b border-orange-hover;
    }
  }
</style>
