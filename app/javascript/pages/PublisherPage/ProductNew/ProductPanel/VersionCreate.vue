<template lang="pug">
  .create-new-version
    .left_and_right
      h3 Create a new version
      .meta
        | Version #
        input.version-number(type="text" v-model="version.number")
        | {{ version.date }}
    FormField(:required="true", title="Files for this version:", description="")
      template(#input): FilesInput(name="Files for this version:" v-model="version.files")
    .left_and_right
      .status.uppercase
        span.text-white-20 Status:&nbsp;
        span.text-white-50 {{ version.status }}
      .actions
        button.middle-btn.second-btn Save as a Draft
        button.middle-btn.main-btn Save
</template>

<script>
import FormField     from "components/inputs/FormField.vue"
import FilesInput    from "components/inputs/files.vue"
import TextInput     from "components/inputs/text.vue"

export default {
  components: {
    FormField,
    FilesInput,
    TextInput,
  },
  data () {
    return {
      version: {
        number: 1,
        status: "draft",
        files: [],
        support: "",
        date: new Date().toLocaleDateString(),
      }
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

  button { @apply ml-6; }
</style>
