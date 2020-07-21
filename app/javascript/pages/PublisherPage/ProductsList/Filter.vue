<template lang="pug">
  .products-filter.flex.flex-col.items-center
    ul.mb-1
      li.filter.inline-block(v-for="filter in filters" :key="filter.name")
        a.cursor-pointer( 
          :class="{'selected_filter': filter.name.toLowerCase() === selected_filter.toLowerCase() }"
          @click.prevent="changeFilter(filter)"
          ) {{ filter.name }} ({{ filter.count }})
        | &nbsp;
    .sorting
      select(v-model="selected_sort")
        option(v-for="sort in sorts" :value="sort") {{ sort.title }}
      | &nbsp;
      | &nbsp;
      label
        input(type="checkbox" name="arrange_by_type" v-model="isGrouped")
        | Arrange by type
</template>

<script>
export default {
  data () {
    return {
      selected_filter: "All",
      selected_sort: "",
      sorts: [
        {
          title: "Newest first",
          field: "created_at",
          order: "desc",
        },
        {
          title: "Oldest first",
          field: "created_at",
          order: "asc",
        },
      ],
      isGrouped: false,
    }
  },
  computed: {
    totalCount () {
      return this.$store.state.products.length
    },
    publishedCount () {
      return this.$store.getters.publics.length
    },
    draftCount () {
      return this.$store.getters.drafts.length
    },
    // pendingCount () {
    //   return this.$store.getters.pendings.length
    // },
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
        // {
        //   name: "Pending approval",
        //   count: this.pendingCount,
        // },
      ].filter(part => part.count > 0)
    },
  },
  watch: {
    selected_sort (newSort) {
      this.$store.commit('setSort', newSort)
    },
    isGrouped (newGrouped) {
      this.$store.commit('setGrouped', newGrouped)
    }
  },
  mounted () {
    this.selected_sort = this.sorts[0]
  },
  methods: {
    changeFilter (filter) {
      this.selected_filter = filter.name
      this.$store.commit('setFilter', filter.name)
    }
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
