<template lang="pug">
  .product-version(:class="{ ['is-published']: version.public }")
    .version-grid
      .version-number ver. {{ version.number }} | id {{ version.id }}
      .version-dates {{ dates }}
      .version-files-title.text-white-20 Files:
      .version-files 
        ul.files: li(v-for="file in version.files"): a.file(:href="file.url") {{ file.filename }}
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
</template>

<script>
import Swither from 'components/inputs/switcher'

export default {
  data () {
    return {
      isLoadingPublicStatus: false
    }
  },
  components: {
    Swither,
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
</style>
