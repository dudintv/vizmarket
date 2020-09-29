<template lang='pug'>
  keep-alive
    router-view
</template>

<script>
export default {
  mounted () {
    this.$store.dispatch('loadCurrentAuthor')
  },
}
</script>
