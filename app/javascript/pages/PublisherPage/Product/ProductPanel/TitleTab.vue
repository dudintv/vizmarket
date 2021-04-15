<template lang="pug">
  .form
    FormField(:required="true", title="Title", description="")
      template(#input): TextInput(name="Title" v-model="product.title")
    FormField(:required="true", title="Short description", description="This text should give customers an idea of your product at a glance. It will be used at the top of your product’s details page and as a tooltip for your product’s thumbnail image. Must be 255 characters or less, but we recommend 100 characters or less.")
      template(#input): TextareaInput(name="Short description" v-model="product.short_description")
    FormField(:required="true", title="Type", description="")
      template(#input): RadioInput(name="Type" v-model="product.kind" :options="kindList")
    FormField(:required="true", title="Category", description="Define the most proper category for your product. Or select “other” and advise new category.")
      template(#input)
        SelectInput(name="Category" v-model="product.categories" :options="categoryList")
          template(#tip)
            | If you didn't find proper category — choose "Other" and 
            a.border-b-1.border-white-20(href="#" @click.prevent="showNewCategory = !showNewCategory") advice a new category
        TextInput(v-if="showNewCategory" name="New advisable category" v-model="newCategory")
</template>

<script>
import FormField     from "components/inputs/FormField.vue"
import TextInput     from "components/inputs/text.vue"
import TextareaInput from "components/inputs/textarea.vue"
import RadioInput    from "components/inputs/radio.vue"
import SelectInput   from "components/inputs/select.vue"

export default {
  data () {
    return {
      showNewCategory: false,
      newCategory: '',
    }
  },
  components: {
    FormField,
    TextInput,
    TextareaInput,
    RadioInput,
    SelectInput,
  },
  computed: {
    product () {
      return this.$store.state.currentProduct
    },
    categoryList () {
      return this.$store.state.categoryList
    },
    kindList () {
      return this.$store.state.kindList
    }
  },
}
</script>
