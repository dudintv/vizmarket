<template lang="pug">
  #settings-page
    #settings-nav
      router-link.settings-link(to="/settings/general") General
      //- router-link.settings-link(to="/settings/payments") Payments
      //- router-link.settings-link(to="/settings/history") History
      router-link.settings-link(to="/settings/password") Password
      //- router-link.settings-link(to="/settings/agreements") Agreements
      router-link.settings-link(to="/settings/linked_accounts") Linked&nbsp;accounts
      router-link.settings-link(to="/settings/publisher") Publisher
      //- router-link.settings-link(to="/settings/help") Heed help?
    #settings-content
      router-view
</template>

<script>
export default {
  mounted () {
    this.$store.dispatch('loadUser')
  },
}
</script>

<style scoped lang="scss">
#settings-page {
  @apply mx-auto w-4_5 py-8 grid;
  min-height: calc(100vh - 52px);
  grid-template-columns: auto 1fr;

  #settings-nav {
    @apply flex flex-col mb-4;
  }
}

.settings-link {
  @apply px-8 py-8 bg-transparent uppercase transition duration-500;

  &:hover {
    @apply bg-blue-20 duration-100;
  }

  &.router-link-exact-active {
    @apply bg-blue-50 border-r-2 border-blue;
  }
}

#settings-content {
  @apply px-8 w-full;
  max-width: 50rem;
}

@media screen and (max-width: 800px) {
  #settings-page {
    width: inherit;
    justify-items: center;
    grid-template-columns: 1fr;
    grid-template-rows: auto 1fr;

    #settings-nav {
      @apply flex-row;
    }
  }

  .settings-link {
    &.router-link-exact-active {
      @apply border-r-0 border-b-2 border-blue;
    }
  }
}
</style>
