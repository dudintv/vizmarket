<template lang="pug">
  .new-product-app
    h1 New Product
    SelectInput(name="Category" v-model="product.categories" :options="categories")
      template(#tip) Hello, this is a tip!
    VideosInput(name="Videos" v-model="product.videos")
      template(#tip) Hello, this is a tip!
    ImageInput(name="Image" v-model="product.featured_image")
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
</template>

<script>
import RulesNotice from './RulesNotice'
import ProductPanel from './ProductPanel'

import TextareaInput from "../../components/inputs/textarea.vue"
import TextInput    from "../../components/inputs/text.vue"
import RadioInput   from "../../components/inputs/radio.vue"
import PriceInput   from "../../components/inputs/price.vue"
import ImageInput   from "../../components/inputs/image.vue"
import ImagesInput  from "../../components/inputs/images.vue"
import FilesInput   from "../../components/inputs/files.vue"
import VideosInput  from "../../components/inputs/videos.vue"
import SelectInput  from "../../components/inputs/select.vue"

export default {
  components: {
    RulesNotice,
    ProductPanel,
    
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
  data: function () {
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

</style>