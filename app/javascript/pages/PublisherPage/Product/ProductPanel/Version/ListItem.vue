<template lang="pug">
  .product-version(:class="{ ['is-published']: version.public }")
    .version-grid
      .version-number Version # {{ version.number }}
      .version-dates {{ dates }}
      .version-files-title.text-white-20 Files:
      .version-files
        ul.files(v-if="version.files"): li(v-for="file in version.files"): a.file(:href="file.url") {{ file.filename }}
        span.text-white-50(v-else) —
      .version-support-title.text-white-20 Support info:
      .version-support.text-white-50 {{ version.support }}
      .version-status.uppercase
        span.text-white-20 status: 
        span.text-white-50 {{ publicStatus }}
      .version-actions
        .flex.align-center.justify-between
          Swither(name="Public" v-model="public" :isFormField="false" :isLoading="isLoadingPublicStatus")
          .buttons
            button.second-btn.middle-btn(@click="editVersion()") Edit
            button.second-btn.middle-btn.ml-4(@click="deleteVersion()") Delete
    .version-script-container(v-if="version.script")
      button.show-script(@click="isShowingScript=!isShowingScript") show attached script
      vue-code-highlight.script(v-if="isShowingScript" language="basic")
        pre.code {{ version.script }}
</template>

<script>
import Swither from 'components/inputs/switcher'
import { component as VueCodeHighlight } from 'vue-code-highlight';
import 'vue-code-highlight/themes/prism-tomorrow.css'
import 'prism-es6/components/prism-markup-templating'
import 'prism-es6/components/prism-basic'

export default {
  data () {
    return {
      isLoadingPublicStatus: false,
      isShowingScript: false,
    }
  },
  components: {
    Swither,
    VueCodeHighlight,
  },
  props: {
    version: Object,
  },
  computed: {
    dates () {
      const created_at = (new Date(this.version.created_at)).toLocaleDateString()
      const updated_at = (new Date(this.version.updated_at)).toLocaleDateString()
      if(created_at === updated_at) {
        return created_at
      } else {
        const updated_at = (new Date(this.version.updated_at)).toLocaleDateString()
        return `${created_at} (${updated_at})`
      }
    },
    public: {
      get () {
        return this.version.public
      },
      set (newValue) {
        this.isLoadingPublicStatus = true
        this.$store.dispatch('versionPublishedChanged', { version: this.version, isPublished: newValue } )
          .then((newPublic) => {
            this.version.public = newPublic
            this.isLoadingPublicStatus = false
          })
      }
    },
    publicStatus () {
      return this.version.public ? "published" : "unpublished"
    }
  },
  methods: {
    editVersion () {
      this.version.isEdit = true
    },
    deleteVersion () {
      this.$backend.versions.delete(this.version.id)
        .then(() => {
          FlashVM.notice('Successfully deleted')
          this.$store.dispatch('updateVersionsList')
        })
        .catch(error => {
          FlashVM.error('Can\'t delete the version with error: ' + error)
        })
    }
  }
}
</script>

<style lang="scss" scoped>
  .product-version {
    @apply bg-unpublished border border-white-05 shadow-md mb-8 p-6;

    &.is-published { @apply bg-published; }
  }

  .version-grid {
    display: grid;
    grid-template-columns: auto 1fr;
    grid-template-rows: auto;
    grid-gap: 1rem;
  }

  .files li {
    @apply block;
  }

  .version-script-container {
    @apply bg-blue-05 -mx-6 mt-6 -mb-6;

    .show-script {
      @apply w-full bg-blue-20 text-orange p-2;

      &:hover {
        @apply text-orange-hover;
      }
    }

    .script {
      @apply p-6;
      max-width: 50vw;
      overflow: scroll;
    }
  }
</style>
