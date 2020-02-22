<template lang="pug">
  .form
    FormField(:required="true", title="Title", description="")
      template(#input): TextInput(name="Title" v-model="title")
    FormField(:required="true", title="Short description",
        description="This text should give customers an idea of your product at a glance. It will be used at the top of your product’s details page and as a tooltip for your product’s thumbnail image. Must be 255 characters or less, but we recommend 100 characters or less.")
      template(#input): TextareaInput(name="Short description" v-model="short_description")
    FormField(:required="true", title="Type", description="")
      template(#input): RadioInput(name="Type" v-model="kind" :options="kinds")
    FormField(:required="true", title="Category", description="Define the most proper category for your product. Or select “other” and advise new category.")
      template(#input)
        SelectInput(name="Category" v-model="categories" :options="category_list")
          template(#tip)
            | If you didn't find proper category — select "Other" and&nbsp;
            a advice a new category
</template>

<script>
import FormField     from "components/inputs/FormField.vue"
import TextInput     from "components/inputs/text.vue"
import TextareaInput from "components/inputs/textarea.vue"
import RadioInput    from "components/inputs/radio.vue"
import SelectInput   from "components/inputs/select.vue"

export default {
  components: {
    FormField,
    TextInput,
    TextareaInput,
    RadioInput,
    SelectInput,
  },
  data () {
    return {
      title: "",
      short_description: "",
      kind: "",
      categories: [],
      
      kinds: [
        "script",
        "scene",
        "plugin",
        "assets",
      ],
      category_list: [
        "transformation",
        "visibility",
        "animation",
        "texture",
        "interactive",
        "utility",
        "other",
      ],
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
