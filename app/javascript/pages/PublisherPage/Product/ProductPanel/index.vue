<template lang="pug">
  .edit-product-page
    .edit-product-panel(:class="bgClass")
      .nav
        ProductThumbnail(:product="product")
        ProductTitle(:product="product")
        .tabs
          router-link.tab(:to="`/publisher/products/${product.id}/title`")
            i.las.la-tag
            span Title & Category
          router-link.tab(:to="`/publisher/products/${product.id}/media`")
            i.las.la-photo-video
            span Images & Video
          router-link.tab(:to="`/publisher/products/${product.id}/texts`")
            i.las.la-align-left
            span Instructions
          router-link.tab.selected(:to="`/publisher/products/${product.id}/files`")
            i.las.la-file-upload
            span Product files
      .content
        keep-alive
          router-view
      .status
        span.text-white-20 status:&nbsp;
        span {{ product.public ? 'Published' : 'Draft' }}
      .actions
        button.big-btn.third-btn(@click="deleteProduct()")
          template(v-if="product.public") Delete the product
          template(v-else) Delete the draft
        button.big-btn.second-btn(v-if="product.public" @click="unpublish()") Unpublish
        button.big-btn.second-btn(v-if="!product.public" @click="saveAndClose()") Save and continue later
        button.big-btn.main-btn(@click="goNext()") {{ nextButtonText }}
</template>

<script>
import ProductThumbnail from 'components/product/thumbnail'
import ProductTitle from 'components/product/title'

export default {
  components: {
    ProductThumbnail,
    ProductTitle,
  },
  data () {
    return {
      isLoaded: false,
    }
  },
  computed: {
    product () {
      return this.$store.state.currentProduct
    },
    bgClass () {
      return this.product.public ? 'bg-published' : 'bg-unpublished'
    },
    nextButtonText () {
      if (this.product.public) {
        return 'Save and close'
      } else {
        switch (this.$route.fullPath.split('/').slice(-1)[0]) {
          case 'title':
          case 'media':
          case 'texts': return 'Save and go next'
          case 'files': return 'Finish and publish'
          default: return 'Next'
        }
      }
    },
    currentTabName () {
      return this.$route.fullPath.split('/').slice(-1)[0]
    }
  },
  activated () {
    this.onMounted()
  },
  methods: {
    onMounted () {
      if (+this.$route.params.id > 0) {
        this.$store.dispatch('loadCurrentProductData', this.$route.params.id)
      } else {
        this.$router.push('/publisher')
      }
    },
    saveCurrentTab () {
      switch (this.currentTabName) {
        case 'title':
          this.$backend.products.update(this.product.id, { product: {
              title: this.product.title,
              short_description: this.product.short_description,
            },
            kind: this.product.kind,
            categories: this.product.categories,
          })
          .then((responce) => {
            if (responce.status == 200) {
              FlashVM.notice('Successfully saved')
            }
          })
          break
        case 'media':
          this.$backend.products.update(this.product.id, { product: {
              videos: this.product.videos,
              youtube_ids: this.product.youtube_ids,
            },
          })
          .then((responce) => {
            if (responce.status == 200) {
              FlashVM.notice('Successfully saved')
            }
          })
          break
        case 'texts':
          this.$backend.products.update(this.product.id, { product: {
              description: this.product.description,
              instruction: this.product.instruction,
            },
          })
          .then((responce) => {
            if (responce.status == 200) {
              FlashVM.notice('Successfully saved')
            }
          })
          break
      }
    },
    goNext () {
      this.saveCurrentTab()
      if (this.product.public) {
        this.$router.push('/publisher')
      } else {
        switch (this.currentTabName) {
          case 'title':
            this.$router.push(`/publisher/products/${this.product.id}/media`)
            break
          case 'media':
            this.$router.push(`/publisher/products/${this.product.id}/texts`)
            break
          case 'texts':
            this.$router.push(`/publisher/products/${this.product.id}/files`)
            break
          case 'files':
            this.$backend.products.publish(this.product.id)
            .then((responce) => {
              if (responce.status == 200) {
                FlashVM.notice('Successfully saved and published')
                this.$router.push('/publisher')
              }
            })
            break
        }
      }
    },
    unpublish () {
      this.$backend.products.unpublish(this.product.id)
        .then(responce => {
          if (responce.status == 200){
            FlashVM.notice('Successfully unpublished')
            this.product.public = false
          }
        })
        .catch(error => {
          FlashVM.error('Can\'t unpublish with error: ' + error)
        })
    },
    saveAndClose () {
      this.saveCurrentTab()
      this.$router.push('/publisher')
    },
    deleteProduct () {
      if (confirm('Are you sure?')){
        this.$backend.products.delete(this.product.id)
          .then(() => {
            this.$router.push('/publisher')
            FlashVM.notice('Successfully deleted')
          })
          .catch(error => {
            FlashVM.error('Can\'t delete the product with error: ' + error)
          })
      }
    },
  }
}
</script>

<style style="scss" scoped>
  .edit-product-panel {
    @apply shadow-2xl mb-8;
    display: grid;
    grid-template-columns: 284px auto;
    grid-template-rows: auto 100px;
    grid-template-areas: 
      "nav content"
      "status actions";
    min-width: 700px;
  }

  .nav {
    @apply flex flex-col;
    grid-area: nav;

    .tabs {
      @apply flex-grow bg-item-50;
    }

    .tab {
      @apply block px-4 py-6 text-xl;

      &.router-link-active {
        @apply bg-red;

        &:hover { @apply bg-red; }
      }

      i { @apply mr-6; }

      &:hover { @apply bg-item; }
    }
  }

  .content {
    @apply px-8 py-6;
    grid-area: content;
  }

  .status, .actions {
    @apply bg-item;
  }

  .status {
    @apply text-xl uppercase text-white-50 flex justify-center items-center;
    grid-area: status;
  }

  .actions {
    @apply flex justify-end items-center;
    grid-area: actions;

    button {
      @apply mr-8;
    }
  }

</style>
