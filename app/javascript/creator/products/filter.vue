<template lang="pug">
  .products-filter.flex.flex-col.items-center
    ul
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
  data: function () {
    return {
      filters: [
        {
          name: "All",
          count: 7,
        },
        {
          name: "Published",
          count: 6,
        },
        {
          name: "Drafts",
          count: 1,
        },
        {
          name: "Pending approval",
          count: 0,
        },
      ],
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
  }
}
</script>

<style scoped lang="scss">
  li.filter {
    @apply .mr-2;
    & + & {
      @apply .pl-3;
      border-left: 1px solid hsla(0,0,100,0.2);
    }
  }

  .selected_filter {
    color: white;
    font-weight: bold;
    border-bottom: 1px solid white;
  }
</style>
