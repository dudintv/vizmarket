<template lang="pug">
  .create-new-version
    .left_and_right
      h3 Create a new version
      .meta
        | Version #
        input.version-number(type="text" v-model="version.number")
        | {{ version.date }}
    FormField(title="Supported Vizrt programs:", description="")
      template(#input): TextareaInput(name="Support info", v-model="version.support")
    FormField(:required="true", title="Files for this version:", description="")
      template(#input): FilesInput(name="Files for this version:", v-model="version.files", inputId="versionFileInput")
    .left_and_right
      .status.uppercase
        span.text-white-20 Status:&nbsp;
        span.text-white-50 not saved
      .actions
        button.middle-btn.third-btn(@click="cancel()") Cancel
        button.middle-btn.second-btn.ml-4(@click="saveAsDraft()") Save as Draft
        button.middle-btn.main-btn.ml-4(@click="saveAsPublish()") Save
</template>

<script>
import FormField     from "components/inputs/FormField.vue"
import FilesInput    from "components/inputs/files.vue"
import TextInput     from "components/inputs/text.vue"
import TextareaInput from "components/inputs/textarea.vue"

export default {
  components: {
    FormField,
    FilesInput,
    TextareaInput,
    TextInput,
  },
  data () {
    return {
      version: {
        number: 1,
        public: false,
        files: [],
        support: "",
        date: new Date().toLocaleDateString(),
      }
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
  },
  methods: {
    cancel () {
      this.$emit('hide')
    },
    saveAsDraft () {
      this.version.public = false
      this.saveVersion()
    },
    saveAsPublish () {
      this.version.public = true
      this.saveVersion()
    },
    saveVersion () {
      const formData = new FormData()
      formData.append('version[number]', this.version.number)
      formData.append('version[public]', this.version.public)
      formData.append('version[support]', this.version.support)
      for (const file of document.getElementById('versionFileInput').files) {
        console.log("file = ", file)
        formData.append('version[files][]', file)
      }

      this.$backend.versions.create(this.product.id, formData)
        .then(() => {
          FlashVM.notice('Successfully created')
          this.$store.dispatch('updateVersionsList')
          this.$emit('hide')
        })
        .catch(error => {
          FlashVM.error('Can\'t crate the version with error: ' + error)
        })
    }
  }
}
</script>

<style lang="scss" scoped>
  .create-new-version {
    @apply bg-unpublished border border-white-05 shadow-md mb-8 p-6;
  }

  .version-number { @apply w-16 px-2 mx-4; }

  .left_and_right { @apply flex items-baseline justify-between; }
</style>
