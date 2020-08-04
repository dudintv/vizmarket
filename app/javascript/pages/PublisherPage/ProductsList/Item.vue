<template lang="pug">
  .publisher-product.shadow-xl.flex.flex-col.lg--flex-row.mb-8(:class="product.public ? 'bg-item': 'bg-item-gray'")
    .product-content.flex.flex-col.sm--flex-row.flex-grow
      .product-cover.min-w-xs.bg-body-darker
        img(v-if="product.thumbnail" :src="product.thumbnail")
        img(v-else src="/images/svg/default-product.svg" )
      .product-info.flex.flex-col.flex-grow
        .product-line.px-4.py-2
          .product-hierachy
            a.uppercase.text-orange.hover--text-orange-hover(href='/') {{ product.kind }}
            span.text-white-50: i.las.la-angle-right.text-base.align-middle
            template(v-for="(category, index) in product.categories")
              a.product-category(href='/') {{ category }}
              template(v-if="index < product.categories.length-1") , 
          .rating
        .product-line.px-4.pb-4.flex.justify-between
          .product-title
            a.text-sm(href='/')
              h3.text-white {{ product.title }}
          .product-price.flex.flex-col.items-end
            h3.text-orange {{ price }}
            span.text-white-50.text-sm(v-if="showTotalEarn") x&nbsp;{{product.purchased_count}}&nbsp;downloads
        .product-line(v-if="product.short_description")
          .product-short-description.px-4.py-2 {{product.short_description}}
        table.product-line.m-4
          tr.product-version(v-for="version in product.versions" :key="version.id" :class="{'opacity-50': !version.public}")
            td.product-version-number.align-top.pt-1.pr-2.w-1
              .border.border-red.px-2.py-1 v&nbsp;{{version.number}}
            td.product-version-info.px-2.py-2
              .product-version-date.text-lg {{ versionDate(version) }}
              .product-version-support.text-sm.opacity-50 {{version.support}}
              ul.files(v-if="version.files"): li(v-for="file in version.files"): a.file(:href="file.url") {{ file.filename }}
              button.show-script-btn(v-if="version.script" @click="isShowScript=true") show attached script
              ModalWindow(v-model="isShowScript")
                vue-code-highlight.script(language="basic")
                  pre.code {{ version.script }}
    .product-actions.flex-grow-0.py-6.border-t-2.border-dashed.border-white-20.lg--border-t-0.lg--border-l-2
      .product-buttons.flex.flex-row.flex-wrap.items-center.justify-center.px-4.lg--flex-col.lg--items-start
        button.product-button(@click="$router.push(`/publisher/products/${product.id}/title`)") Edit&nbsp;main&nbsp;info
        button.product-button(@click="$router.push(`/publisher/products/${product.id}/files`)") Add/Edit&nbsp;versions
        button.product-button(v-if="product.public" @click="unpublish(product.id)") Unpublish
        button.product-button(v-else @click="publish(product.id)") Publish
      ul.product-dates.text-sm.flex.justify-center.mx-6.my-4.text-white-50.lg--flex-col
        li.product-date.mr-4 Created {{ prettyDate(product.created_at) }}
        li.product-date Updated {{ prettyDate(product.updated_at) }}
      .product-status.mx-5.flex.justify-center.uppercase.text-white-50.lg--justify-start
        .product-published(v-if="product.public")
          i.las.la-globe
          | Published
        .product-draft(v-else)
          i.las.la-pen
          | Draft
</template>

<script>
import ModalWindow from 'components/common/ModalWindow'
import { component as VueCodeHighlight } from 'vue-code-highlight';
import 'vue-code-highlight/themes/prism-tomorrow.css'
import 'prism-es6/components/prism-markup-templating'
import 'prism-es6/components/prism-basic'

export default {
  components: {
    ModalWindow,
    VueCodeHighlight,
  },
  props: {
    product: Object
  },
  data () {
    return {
      isShowScript: false,
    }
  },
  computed: {
    showTotalEarn () {
      return this.product.price > 0 && this.product.purchased_count > 0;
    },
    price () {
      if (this.product.price > 0) {
        return `\$ ${this.product.price}`;
      }else{
        return "FREE";
      }
    }
  },
  methods: {
    prettyDate (date_in_string) {
      return new Date(date_in_string).toLocaleDateString();
    },
    versionDate (version) {
      const created_at = this.prettyDate(version.created_at)
      const updated_at = this.prettyDate(version.updated_at)
      if (created_at === updated_at) {
        return created_at
      } else {
        return `${created_at} (${updated_at})`
      }
    },
    publish (id) {
      this.$backend.products.publish(id)
        .then(response => {
          this.$store.commit({ type: 'changeProductPublic', id, newPublic: true })
          FlashVM.notice('Successfully published')
        })
        .catch(error => {
          console.warn('Can\'t update products data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
    unpublish (id) {
      this.$backend.products.unpublish(id)
        .then(response => {
          this.$store.commit({ type: 'changeProductPublic', id, newPublic: false })
          FlashVM.notice('Successfully unpublished')
        })
        .catch(error => {
          console.warn('Can\'t update products data. Error: ', error)
          FlashVM.alert(error.message)
        })
    },
  }
}
</script>

<style scoped lang="scss">
  .product-short-description{
    background: linear-gradient(119.02deg, #0081CE 0%, rgba(0, 115, 184, 0.680985) 2.68%, rgba(0, 102, 162, 0.376874) 7.07%, rgba(0, 85, 136, 0) 28.7%), linear-gradient(90deg, rgba(0, 77, 124, 0.25) 0%, rgba(0, 45, 71, 0) 100%);
  }
  .product-version-number{
    height: fit-content;
  }
  .product-button{
    @apply bg-white-20 rounded-full px-4 py-2 mb-2 mx-1 uppercase;

    &:hover{
      @apply bg-white-50;
    }
  }
  .product-cover {
    width: 288px;
    height: 288px;
  }

  .show-script-btn {
    @apply bg-blue-20 text-orange px-2 py-1;

    &:hover {
      @apply text-orange-hover;
    }
  }

  .script {
    max-height: 95vh;
    min-width: 30vw;
  }
</style>
