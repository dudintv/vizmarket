<template lang="pug">
  .form-field
    .field-with-label
      textarea(ref="textarea" :name="name" :id="name" :value="value" @input="$emit('input', $event.target.value);textareaAutoGrowth();" placeholder=" ")
      label(:for="name"): .input-name YouTube links
    .videos.flex.flex-wrap
      iframe(
        v-for="video_id in video_ids" :key="video_id"
        width='240', 
        height='135', 
        :src="`https://www.youtube.com/embed/${video_id}`", 
        frameborder='0', 
        allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture', 
        allowfullscreen=''
      )
    .tip(v-if="$slots['tip']")
      slot(name="tip")
</template>

<script>
export default {
  props: {
    name: String,
    value: String,
  },
  data () {
    return {
      videos: "",
    }
  },
  computed: {
    video_ids () {
      // https://www.youtube.com/watch?v=j-HkuKxTYEU
      // https://youtu.be/O13ZItlALxg
      // youtu.be/mbbfyWyQGWg
      let youtube_regexp = /(?:https?:)?(?:\/\/)?(?:[0-9A-Z-]+\.)?(?:youtu\.be\/|youtube(?:-nocookie)?\.com\/\S*?[^\w\s-])((?!videoseries)[\w-]{11})(?=[^\w-]|$)(?![?=&+%\w.-]*(?:['"][^<>]*>|<\/a>))[?=&+%\w.-]*/
      let arr = this.value.split(/\s+/).filter( line => youtube_regexp.test(line) ).map( line => youtube_regexp.exec(line)[1] );
      return arr
      // return ["LDDy4m_TiVk", "TjE2w9Gng8g", "j-HkuKxTYEU"]
    }
  },
  methods: {
    textareaAutoGrowth () {
      let el = this.$refs.textarea;
      el.style.height = (el.scrollHeight)+"px";
    }
  }
}
</script>

<style scoped lang="scss">

</style>
