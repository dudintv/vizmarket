<template lang="pug">
  .new-product
    RulesNotice(image="/images/anons/take-a-look.jpg")
    h1 Create new product
    ProductPanel
</template>

<script>
import RulesNotice from "./RulesNotice"
import ProductPanel from "./ProductPanel"
import StartCreate from "./StartCreate"

export default {
  components: {
    RulesNotice,
    ProductPanel,
    StartCreate,
  }
}
</script>

<style lsng="scss" scoped>
</style>
