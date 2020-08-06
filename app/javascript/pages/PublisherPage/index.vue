<template lang='pug'>
  keep-alive
    router-view
</template>

<script>
export default {
  watch: {
    '$route' (to, from) {
      console.log("FROM", from.path, '  TO', to.path)
    }
  }
}
</script>
