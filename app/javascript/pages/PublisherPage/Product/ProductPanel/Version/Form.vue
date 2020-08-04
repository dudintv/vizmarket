<template lang="pug">
  .editing-version(:class="{ ['is-published']: version.public }")
    .left_and_right
      h3(v-if="isCreating") Create a new version
      h3(v-else) Edit the version
      .meta
        | Version #
        input.version-number(type="text" v-model="newNumber")
        | {{ version.date }}
    FormField(title="Supported Vizrt programs:", description="")
      template(#input): TextareaInput(name="Support info", v-model="newSupport")
    FormField(title="Files for this version:", description="")
      template(#input)
        ul.files(v-if="oldFiles.length > 0")
          li(v-for="file in oldFiles")
            a.file(:href="file.url" :class="{'removed': file.isRemoved}") {{ file.filename }}
            a.remove(v-if="file.isRemoved" @click.prevent="undoRemoveFile(file)") undo
            a.remove(v-else @click.prevent="removeFile(file)") delete
        FilesInput(name="Files for this version:", v-model="newFiles", inputId="versionFileInput")
    .script-section(v-if="product.kind=='script'")
      h5 Script code
      p This script will be avaliable in "fast copy to clipboard" feature.
      TextareaInput(name="Script", v-model="script", maxHeightCss="95vh")
    .left_and_right
      .status.uppercase
        span.text-white-20 Status:&nbsp;
        span.text-white-50 {{ status }}
      .actions
        button.middle-btn.third-btn(@click="cancel()") Cancel
        button.middle-btn.second-btn.ml-4(v-if="isCreating" @click="saveAsDraft()") Save as Draft
        button.middle-btn.main-btn.ml-4(@click="save()") Save
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
  props: {
    isCreating: {
      type: Boolean,
      default: false,
    },
    version: {
      type: Object,
      default () {
        return {
          number: 1,
          public: false,
          files: [],
          support: "",
          date: new Date().toLocaleDateString(),
        }
      }
    }
  },
  data () {
    return {
      script: '',
      newNumber: 1,
      newSupport: '',
      newPublic: false,
      newFiles: [],
      oldFiles: [],
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
    status () {
      if (this.isCreating) {
        return 'not saved'
      } else {
        return this.version.public ? 'published' : 'unpublished'
      }
    }
  },
  mounted () {
    console.debug("version.files", this.version.files.length)
    if (!this.isCreating) {
      this.newNumber = this.version.number
      this.newSupport = this.version.support
      this.newPublic = this.version.public
      this.oldFiles = this.version.files
      this.script = this.version.script
    }
  },
  methods: {
    cancel () {
      this.$emit('hide')
    },
    saveAsDraft () {
      this.newPublic = false
      this.saveNewVersion()
    },
    save () {
      if (this.isCreating) {
        this.newPublic = true
        this.saveNewVersion()
      } else {
        this.saveVersion()
      }
    },
    getFormData () {
      const formData = new FormData()
      formData.append('version[number]', this.newNumber)
      formData.append('version[support]', this.newSupport)
      formData.append('version[public]', this.newPublic)
      for (const file of document.getElementById('versionFileInput').files) {
        formData.append('version[files][]', file)
      }
      for (const file of this.oldFiles) {
        if (file.isRemoved) {
          formData.append('version[remove_files][]', file.id)
        }
      }
      if (this.product.kind === 'script') {
        formData.append('version[script]', this.script)
      }
      return formData
    },
    saveNewVersion () {
      this.$backend.versions.create(this.product.id, this.getFormData())
        .then(() => {
          FlashVM.notice('Successfully created')
          this.$store.dispatch('updateVersionsList')
          this.$emit('hide')
        })
        .catch(error => {
          FlashVM.error(`Can't create the version with error: ${error}`)
        })
    },
    saveVersion () {
      this.$backend.versions.update(this.version.id, this.getFormData())
        .then(() => {
          FlashVM.notice('Successfully updated')
          this.$store.dispatch('updateVersionsList')
          this.$emit('hide')
        })
        .catch(error => {
          FlashVM.error(`Can't update the version with error: ${error}`)
        })
    },
    removeFile (file) {
      file.isRemoved = true
    },
    undoRemoveFile (file) {
      file.isRemoved = false
    },
  }
}
</script>

<style lang="scss" scoped>
  .editing-version {
    @apply bg-unpublished border border-white-05 shadow-md mb-8 p-6;

    &.is-published {
      @apply bg-published;
    }
  }

  .version-number { @apply w-16 px-2 mx-4; }

  .left_and_right { @apply flex items-baseline justify-between; }

  .remove {
    @apply cursor-pointer ml-2 text-red;

    &:hover {
      @apply text-red-hover;
    }
  }

  .removed {
    @apply line-through opacity-50;
  }
</style>
