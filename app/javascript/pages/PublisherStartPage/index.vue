<template lang="pug">
  #publisher-start-app
    h1 Become a Publisher
    p.text-center.text-white-80.mb-8 If you want to share your content, please fill in these fields.
    Stepper(:steps="steps")
    .form-container
      keep-alive
        router-view
</template>

<script>
import Stepper from 'components/common/Stepper'

export default {
  components: {
    Stepper,
  },
  data () {
    return {
      // author: {},
      steps: [
        {
          name: 1,
          title: 'Store info (public)',
          link: '/publisher/author/start/public',
          invalid: undefined,
          done: false,
        },
        {
          name: 2,
          title: 'Personal info (private)',
          link: '/publisher/author/start/private',
          invalid: undefined,
          done: false,
        },
      ],
    }
  },
  mounted () {
    this.$store.dispatch('loadAuthor')
  },
}
</script>
