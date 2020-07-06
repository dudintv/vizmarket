<template lang="pug">
  .products-filter.flex.flex-col.items-center
    ul.mb-1
      li.filter.inline-block(v-for="filter in filters" :key="filter.name")
        a(
          href='/' 
          :class="{'selected_filter': filter.name.toLowerCase() === selected_filter.toLowerCase() }"
          ) {{ filter.name }} ({{ filter.count }})
        | &nbsp;
    .sorting
      select
        option(v-for="sort in sorts" value="sort.field") {{ sort.title }}
      | &nbsp;
      | &nbsp;
      label
        input(type="checkbox" name="arrange_by_type" checked)
        | Arrange by type
</template>

<script>
export default {
  data () {
    return {
      selected_filter: "All",
      sorts: [
        {
          title: "Newest first",
          field: "created_at",
          order: "DESC",
        },
        {
          title: "Oldest first",
          field: "created_at",
          order: "ASC",
        },
      ],
      arrange_by_type: false,
    }
  },
  computed: {
    totalCount () {
      console.log(this.$store.state.products)
      return this.$store.state.products.length
    },
    publishedCount () {
      return this.$store.getters.published.length
    },
    draftCount () {
      return this.$store.getters.drafts.length
    },
    pendingCount () {
      return this.$store.getters.pendings.length
    },
    filters () {
      return [
        {
          name: "All",
          count: this.totalCount,
        },
        {
          name: "Published",
          count: this.publishedCount,
        },
        {
          name: "Drafts",
          count: this.draftCount,
        },
        {
          name: "Pending approval",
          count: this.pendingCount,
        },
      ].filter(part => part.count > 0)
    },
  }
}
</script>

<style scoped lang="scss">
  li.filter {
    @apply mr-2;
    & + & {
      @apply pl-3 border-l border-white-20;
    }
  }

  .selected_filter {
    @apply text-white font-bold border-b border-white;
  }

  select {
    @apply bg-white-05 text-white border border-white rounded-full;
  }
</style>
