<template lang="pug">
  .product-version(:class="{ ['is-published']: is_published }")
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
      tr
        td: Swither(name="Published" v-model="is_published")
        td
          button.second-btn.middle-btn Edit
          | &nbsp;
          button.second-btn.middle-btn Delete
</template>

<script>
import Swither from 'components/inputs/switcher'
import { clone } from 'utils/object'

export default {
  components: {
    Swither,
  },
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
    },
    is_published: {
      get () {
        return this.version.status === "published"
      },
      set (newValue) {
        this.$store.dispatch('versionPublishedChanged', { version: this.version, is_published: newValue } )
      }
    }
  },
}
</script>

<style lang="scss" scoped>
  .product-version {
    @apply bg-unpublished border border-white-05 shadow-md mb-8 p-6;

    &.is-published { @apply bg-published; }
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
