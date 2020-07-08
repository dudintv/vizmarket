<template lang="pug">
  .form
    FormField(:required="true", title="Thumbnail", description="This image will be clicked to lead users from the homepage or search results of the Marketplace to your product’s details page. Must have a resolution of 288x288.")
      template(#input): ImageInput(name="Thumbnail" v-model="product.thumbnail" recommendations="288 × 288")
    FormField(:required="true", title="Featured image", description="This image may be used for feature placement on the homepage of the Marketplace. Must have a resolution of 1920x1080.")
      template(#input): ImageInput(name="Featured image" v-model="product.featured_image" recommendations="1920 × 1080")
    FormField(title="YouTube videos", description="Add links to video(s) describes how the Product works. Also, the video will give an instruction how to setup and use it.")
      template(#input): VideosInput(name="YouTube videos" v-model="product.videos" @updateIds="updateVideoIds")
    FormField(title="Gallery", description="These images will be displayed on your product’s details page and should contain in-engine shots of original assets with an overview map if applicable. Must contain 1-25 images, each with a resolution of 1920x1080.")
      template(#input): ImagesInput(name="Gallery" v-model="product.gallery")
</template>

<script>
import FormField   from "components/inputs/FormField.vue"
import ImageInput  from "components/inputs/image.vue"
import ImagesInput from "components/inputs/images.vue"
import VideosInput from "components/inputs/videos.vue"

export default {
  components: {
    FormField,
    ImageInput,
    ImagesInput,
    VideosInput,
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
  },
  methods: {
    updateVideoIds (ids) {
      this.$store.commit('setYoutubeIds', ids.join(' '))
    }
  }
}
</script>
