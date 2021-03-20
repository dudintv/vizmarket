<template lang="pug">
#settings-invitations
  h2.mb-4 My invitations
  .invitations.flex.flex-col.mb-4
    .invitation.flex(v-for="invitation in invitations")
      .status.w-3.h-3.rounded-full.mt-1.mr-2(:class="invitation.active ? 'bg-green' : 'bg-red'")
      span(:class="invitation.active? 'text-white': 'text-white-30'") {{ invitation.code }}
  button.btn.main-btn.big-btn(@click="createInvitations") create invitations
</template>

<script>
export default {
  computed: {
    invitations: {
      get () { return this.$store.state.invitations },
    },
  },
  mounted () {
    this.$store.dispatch('loadInvitations')
  },
  methods: {
    createInvitations () {
      this.$store.dispatch('createInvitations')
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
