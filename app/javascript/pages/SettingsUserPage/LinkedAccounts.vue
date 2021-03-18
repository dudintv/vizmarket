<template lang="pug">
  #settings-linked-account
    h2.mb-4 Your linked accounts
    .socnetworks
      .socnetwork(v-for="account in user.linkedAccounts")
        .socnetwork-describing
          img(:src="`/images/svg-icons/${account}.svg`")
          span.name {{ account }}
        button.btn.second-btn.middle-btn.w-full(@click="destroyAccountLink(account)") delete link
</template>

<script>

export default {
  computed: {
    user: {
      get () { return this.$store.state.currentUser },
      // set (value) { this.$store.commit('setCurrentUser', value) }
    },
  },
  methods: {
    destroyAccountLink (account) {
      this.$store.dispatch('destroyAccountLink', account)
    },
  },
}
</script>

<style scoped lang="scss">
.socnetworks {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  grid-gap: 20px;
}

.socnetwork {
  @apply border border-white flex flex-col items-center;

  &:hover {
    @apply bg-white-03;
  }
}

.socnetwork-describing {
  @apply p-6 flex flex-col items-center;
}
</style>
