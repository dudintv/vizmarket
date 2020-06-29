<template lang="pug">
  .new-product-app
    h1 All inputs
    .flex
      form.flex-grow.mr-4
        h3 Simple
        SelectInput(name="Category" v-model="product.categories" :options="categories")
        VideosInput(name="Videos" v-model="product.videos")
        ImageInput(name="Image" v-model="product.featured_image" recommendations="1920 x 1080")
        ImagesInput(name="Images" v-model="product.images")
        FilesInput(name="Files" v-model="product.files")
        TextInput(name="Title" v-model="product.title")
        TextInput(name="Description" v-model="product.description")
        TextareaInput(name="Instruction" v-model="product.instruction")
        RadioInput(name="Type" v-model="product.kind" :options="kinds")
        PriceInput(name="Price" v-model="product.price")

      form.flex-grow
        h3 With tips
        SelectInput(name="Category" v-model="product.categories" :options="categories")
          template(#tip) Hello, this is a tip!
        VideosInput(name="Videos" v-model="product.videos")
          template(#tip) Hello, this is a tip!
        ImageInput(name="Image" v-model="product.featured_image" recommendations="1920 x 1080")
          template(#tip) Hello, this is a tip!
        ImagesInput(name="Images" v-model="product.images")
          template(#tip) Hello, this is a tip!
        FilesInput(name="Files" v-model="product.files")
          template(#tip) Hello, this is a tip!
        TextInput(name="Title" v-model="product.title")
          template(#tip) Hello, this is a tip!
        TextInput(name="Description" v-model="product.description")
          template(#tip) Hello, this is a tip!
        TextareaInput(name="Instruction" v-model="product.instruction")
          template(#tip) Hello, this is a tip!
        RadioInput(name="Type" v-model="product.kind" :options="kinds")
          template(#tip) Hello, this is a tip!
        PriceInput(name="Price" v-model="product.price")
          template(#tip) Hello, this is a tip!
    
    h1 Validations

    h3 Common .error_explanation
    .flex
      .flex-grow.mr-4
        .error_explanation
          ul
            li Single error
      .flex-grow
        .error_explanation
          h5 There are some errors
          ul
            li First error
            li Second error
      
    h3 Fields with errors
    .flex
      form.flex-grow.mr-4
        SelectInput.has_error(name="Category" v-model="product.categories" :options="categories")
          template(#error) And, this is an error.
        VideosInput.has_error(name="Videos" v-model="product.videos")
          template(#error) And, this is an error.
        ImageInput.has_error(name="Image" v-model="product.featured_image" recommendations="1920 x 1080")
          template(#error) And, this is an error.
        ImagesInput.has_error(name="Images" v-model="product.images")
          template(#error) And, this is an error.
        FilesInput.has_error(name="Files" v-model="product.files")
          template(#error) And, this is an error.
        TextInput.has_error(name="Title" v-model="product.title")
          template(#error) And, this is an error.
        TextInput.has_error(name="Description" v-model="product.description")
          template(#error) And, this is an error.
        TextareaInput.has_error(name="Instruction" v-model="product.instruction")
          template(#error) And, this is an error.
        RadioInput.has_error(name="Type" v-model="product.kind" :options="kinds")
          template(#error) And, this is an error.
        PriceInput.has_error(name="Price" v-model="product.price")
          template(#error) And, this is an error.

      form.flex-grow
        SelectInput.has_error(name="Category" v-model="product.categories" :options="categories")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        VideosInput.has_error(name="Videos" v-model="product.videos")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        ImageInput.has_error(name="Image" v-model="product.featured_image" recommendations="1920 x 1080")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        ImagesInput.has_error(name="Images" v-model="product.images")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        FilesInput.has_error(name="Files" v-model="product.files")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        TextInput.has_error(name="Title" v-model="product.title")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        TextInput.has_error(name="Description" v-model="product.description")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        TextareaInput.has_error(name="Instruction" v-model="product.instruction")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        RadioInput.has_error(name="Type" v-model="product.kind" :options="kinds")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
        PriceInput.has_error(name="Price" v-model="product.price")
          template(#tip) Hello, this is a tip!
          template(#error) And, this is an error.
    
    h1 FormFields

    .flex
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
            SelectInput(name="Category" v-model="product.categories" :options="categories")
              template(#tip)
                | If you didn't find proper category — select "Other" and&nbsp;
                a advice a new category

        FormField(:required="true", title="Detailed description", description="Provide a full explanation of your product and set the expectations of what it can be used for. Must be 1900 characters or less.")
          template(#input): TextareaInput(name="Detailed description" v-model="description")
        FormField(:required="true", title="How to install and use", description="This text should provide all the discrete data that details the contents of your product and how it can be used. Links to any documentation or instructional material should appear here. Must be 1900 characters or less.")
          template(#input): TextareaInput(name="How to install and use" v-model="instruction")
        
        FormField(:required="true", title="Thumbnail", description="This image will be clicked to lead users from the homepage or search results of the Marketplace to your product’s details page. Must have a resolution of 288x288.")
          template(#input): ImageInput(name="Thumbnail" v-model="thumbnail" recommendations="288 × 288")
        FormField(:required="true", title="Featured image", description="This image may be used for feature placement on the homepage of the Marketplace. Must have a resolution of 1920x1080.")
          template(#input): ImageInput(name="Featured image" v-model="featured_image" recommendations="1920 × 1080")
        FormField(title="YouTube videos", description="Add links to video(s) describes how the Product works. Also, the video will give an instruction how to setup and use it.")
          template(#input): VideosInput(name="Videos" v-model="product.videos")
        FormField(title="Gallery", description="These images will be displayed on your product’s details page and should contain in-engine shots of original assets with an overview map if applicable. Must contain 1-25 images, each with a resolution of 1920x1080.")
          template(#input): ImagesInput(name="Gallery" v-model="gallery")
</template>

<script>
import RulesNotice from './../PublisherPage/ProductNew/RulesNotice'
import FormField from 'components/inputs/FormField'

import TextareaInput from "components/inputs/textarea.vue"
import TextInput    from "components/inputs/text.vue"
import RadioInput   from "components/inputs/radio.vue"
import PriceInput   from "components/inputs/price.vue"
import ImageInput   from "components/inputs/image.vue"
import ImagesInput  from "components/inputs/images.vue"
import FilesInput   from "components/inputs/files.vue"
import VideosInput  from "components/inputs/videos.vue"
import SelectInput  from "components/inputs/select.vue"

export default {
  components: {
    RulesNotice,
    FormField,
    
    TextInput,
    TextareaInput,
    RadioInput,
    PriceInput,
    ImageInput,
    ImagesInput,
    FilesInput,
    VideosInput,
    SelectInput,
  },
  data () {
    return {
      product: {
        title: "",
        short_description: "",
        description: "",
        instruction: "",
        kind: "",
        categories: [],
        price: 0,
        thumbnail: null,
        featured_image: null,
        images: [],
        videos: "",
        public: false,
        files: [],
      },
      kinds: [
        "script",
        "scene",
        "plugin",
      ],
      categories: [
        "transformation",
        "visibility",
        "animation",
        "texture",
        "interactive",
        "utility",
      ],
    }
  }
}
</script>

<style scoped lang="scss">
  h3 {
    margin-top: 2rem;
    margin-bottom: 1rem;
  }
</style>