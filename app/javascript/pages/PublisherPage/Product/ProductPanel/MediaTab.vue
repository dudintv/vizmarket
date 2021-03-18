<template lang="pug">
  .form
    FormField(:required="true", title="Thumbnail", description="This image will be clicked to lead users from the homepage or search results of the Marketplace to your product’s details page. Must be squared. The optimal resolution is 568 × 568.")
      template(#input): ImageInput(name="Thumbnail" v-model="product.thumbnail" recommendations="568 × 568" :isLoading="isThumbnailLoading" :successMessage="thumbnailSuccessMessage" :errorMessage="thumbnailErrorMessage")
    FormField(:required="true", title="Featured image", description="This image may be used for feature placement on the homepage of the Marketplace. Must have a resolution of 1920 × 1080.")
      template(#input): ImageInput(name="Featured image" v-model="product.featuredImage" recommendations="1920 × 1080" :aspect="16.0/9.0" :isLoading="isFeatureImageLoading" :successMessage="featuredImageSuccessMessage" :errorMessage="featuredImageErrorMessage")
    FormField(title="YouTube videos", description="Add links to video(s) describes how the Product works. Also, the video will give an instruction how to setup and use it.")
      template(#input): VideosInput(name="YouTube videos" v-model="product.videos" @updateIds="updateVideoIds")
    FormField(title="Gallery", description="These images will be displayed on your product’s details page and should contain in-engine shots of original assets with an overview map if applicable. Must contain 1-25 images, each with a resolution of 1920x1080.")
      template(#input): ImagesInput(name="Gallery" v-model="product.images" @uploadImages="uploadGalleryImages" @remove="removeGalleryImage" :isLoading="isImagesLoading" :successMessage="imagesSuccessMessage" :errorMessage="imagesErrorMessage")
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
  data () {
    return {
      isThumbnailLoading: false,
      thumbnailSuccessMessage: '',
      thumbnailErrorMessage: '',
      isFeatureImageLoading: false,
      featuredImageSuccessMessage: '',
      featuredImageErrorMessage: '',
      isImagesLoading: false,
      imagesSuccessMessage: '',
      imagesErrorMessage: '',
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct;
    },
  },
  watch: {
    ['product.thumbnail'] (newImage) {
      this.isThumbnailLoading = true
      if (this.product.thumbnail) {
        // UPLOAD IMAGE
        fetch(this.product.thumbnail)
          .then( res => res.blob())
          .then( blob => {
            const formData = new FormData()
            formData.append('thumbnail', blob)
            return this.$backend.products.uploadThumbnail(this.product.id, formData)
          })
          .then(response => {
            this.thumbnailSuccessMessage = 'Loaded successfully'
            this.thumbnailErrorMessage = ''
            setTimeout(() => {
              this.thumbnailSuccessMessage = ''
            }, 2000)
            console.log('SUCCES', response)
          })
          .catch(error => {
            this.thumbnailErrorMessage = error.message
            console.warn('ERROR', error)
          })
          .finally(() => {
            this.isThumbnailLoading = false
          })
      } else {
        // DELETE IMAGE
        this.$backend.products.deleteThumbnail(this.product.id)
          .then(response => {
            this.thumbnailSuccessMessage = 'Deleted successfully'
            this.thumbnailErrorMessage = ''
            setTimeout(() => {
              this.thumbnailSuccessMessage = ''
            }, 2000)
            console.log('SUCCES', response)
          })
          .catch(error => {
            this.thumbnailErrorMessage = error
            console.warn('ERROR', error)
          })
          .finally(() => {
            this.isThumbnailLoading = false
          })
      }
    },
    ['product.featuredImage'] (newImage) {
      this.isFeaturedImageLoading = true
      if (this.product.featuredImage) {
        // UPLOAD IMAGE
        fetch(this.product.featuredImage)
          .then( res => res.blob())
          .then( blob => {
            const formData = new FormData()
            formData.append('featured_image', blob)
            return this.$backend.products.uploadFeaturedImage(this.product.id, formData)
          })
          .then(response => {
            this.featuredImageSuccessMessage = 'Loaded successfully'
            this.featuredImageErrorMessage = ''
            setTimeout(() => {
              this.featuredImageSuccessMessage = ''
            }, 2000)
            console.log('SUCCESS', response)
          })
          .catch(error => {
            this.featuredImageErrorMessage = error.message
            console.warn('ERROR', error)
          })
          .finally(() => {
            this.isFeaturedImageLoading = false
          })
      } else {
        // DELETE IMAGE
        this.$backend.products.deleteFeaturedImage(this.product.id)
          .then(response => {
            this.featuredImageSuccessMessage = 'Deleted successfully'
            this.featuredImageErrorMessage = ''
            setTimeout(() => {
              this.featuredImageSuccessMessage = ''
            }, 2000)
            console.log('SUCCESS', response)
          })
          .catch(error => {
            this.featuredImageErrorMessage = error
            console.warn('ERROR', error)
          })
          .finally(() => {
            this.isFeaturedImageLoading = false
          })
      }
    },
  },
  methods: {
    updateVideoIds (ids) {
      this.$store.commit('setYoutubeIds', ids.join(' '))
    },
    uploadGalleryImages (images) {
      this.isImagesLoading = true
      const formData = new FormData()
      for (let x = 0; x < images.length; x++) {
        formData.append('images[]', images[x])
      }
      this.$backend.products.uploadGalleryImages(this.product.id, formData)
        .then(response => {
          this.$store.commit('setImages', response.data.data.attributes.images)
          this.imagesSuccessMessage = 'Loaded successfully'
          this.imagesErrorMessage = ''
          setTimeout(() => {
            this.imagesSuccessMessage = ''
          }, 2000)
          console.log('SUCCESS', response)
        })
        .catch(error => {
          this.imagesSuccessMessage = ''
          this.imagesErrorMessage = error.message
          console.warn('ERROR', error)
        })
        .finally(() => {
          this.isImagesLoading = false
        })
    },
    removeGalleryImage (key) {
      this.$backend.products.deleteImage(key)
        .then(response => {
          this.$store.commit('removeGalleryImage', key)
          this.imagesSuccessMessage = 'Deleted successfully'
          this.imagesErrorMessage = ''
          setTimeout(() => {
            this.imagesSuccessMessage = ''
          }, 2000)
          console.log('SUCCESS', response)
        })
        .catch(error => {
          this.imagesSuccessMessage = ''
          this.imagesErrorMessage = error.message
          console.warn('ERROR', error)
        })
        .finally(() => {
          this.isImagesLoading = false
        })
    }
  }
}
</script>
