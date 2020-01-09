<template lang="pug">
  .creator-product.bg-item.shadow-xl.flex.flex-col.lg--flex-row
    .product-content.flex.flex-col.sm--flex-row.flex-grow
      .product-cover.min-w-xs.bg-body-darker
        img(src="product.cover" v-if="product.cover")
        img(src="/images/svg/default-product.svg" v-else)
      .product-info.flex.flex-col.flex-grow
        .product-line.px-4.py-2
          .product-hierachy
            a.text-orange.hover--text-orange-hover(href='/') {{ product.kind }}
            span.text-white-50: i.las.la-angle-right.text-base.align-middle
            a.product-category(href='/') {{ product.category }}
          .rating
        .product-line.px-4.pb-4.flex.justify-between
          .product-title
            a.text-sm(href='/')
              h3.text-white {{ product.title }}
          .product-price.flex.flex-col.items-end
            h3.text-orange {{ price }}
            span.text-white-50.text-sm(v-if="showTotalEarn") x&nbsp;{{product.purchased_count}}&nbsp;downloads
        .product-line
          .product-short-description.px-4.py-2 {{product.short_description}}
        table.product-line.m-4
          tr.product-version(v-for="version in product.versions")
            td.product-version-number.align-top.pt-1.pr-2.w-1
              .border.border-red.px-2.py-1 v&nbsp;{{version.number}}
            td.product-version-info.px-2.py-2
              .product-version-date.text-lg {{prettyDate(version.created_at)}}
              .product-version-developed-for.text-sm.opacity-50 {{version.developed_for}}
              .product-version-tested-for.text-sm.text-orange.opacity-50 {{version.tested_in}}
    .product-actions.flex-grow-0.py-6.border-t-2.border-dashed.border-white-20.lg--border-t-0.lg--border-l-2
      .product-buttons.flex.flex-row.flex-wrap.items-center.justify-center.px-4.lg--flex-col.lg--items-start
        a.product-button(href="#") Edit&nbsp;main&nbsp;info
        a.product-button(href="#") Add/Edit&nbsp;versions
        a.product-button(href="#") Unpublish
      ul.product-dates.text-sm.flex.justify-center.mx-6.my-4.text-white-50.lg--flex-col
        li.product-date.mr-4 Created {{prettyDate(product.created_at)}}
        li.product-date Updated {{prettyDate(product.updated_at)}}
      .product-status.mx-5.flex.justify-center.uppercase.text-white-50.lg--justify-start
        .product-published(v-if="product.public")
          i.las.la-globe
          | Published
        .product-draft(v-else)
          i.las.la-pen
          | Draft
</template>

<script>
export default {
  props: {
    product: Object
  },
  computed: {
    showTotalEarn: function () {
      return this.product.price > 0 && this.product.purchased_count > 0;
    },
    price: function () {
      if (this.product.price > 0) {
        return `\$ ${this.product.price}`;
      }else{
        return "FREE";
      }
    }
  },
  methods: {
    prettyDate: function(date_in_string) {
      return new Date(date_in_string).toLocaleDateString();
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

</style>
