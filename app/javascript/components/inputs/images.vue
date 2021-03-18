<template lang="pug">
  .form-field
    .container
      .image_container
        //- inspired by https://www.npmjs.com/package/vue-picture-upload
        .image(v-for="i in value" :key="i['key']" :style="GetStyle(i['image_preview'])")
          .image_button_container
            button.reset.remove(@click="Remove(i)") +
        input(type="file" id="file" ref="file" accept="images/*" multiple v-on:change="handleFileUpload()")
        button.add.reset.flex-grow(@click="Select()") +
      .loading-container
        .loading(v-if="isLoading")
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
export default {
  props: {
    name: String,
    value: {
      type: Array,
      default: () => {
        return []
      }
    },
    isLoading: {
      type: Boolean,
      default: false,
    },
    successMessage: {
      type: String,
      default: '',
    },
    errorMessage: {
      type: String,
      default: '',
    },
  },
  methods: {
    Select () {
      this.$refs.file.click()
    },
    Remove (e) {
      this.$emit("remove", e.key)
    },
    handleFileUpload () {
      const files = this.$refs.file.files;
      this.$emit('uploadImages', files)
    },
    GetStyle(image) {
      return {
        "background-image": "url(" + image + ")"
      };
    },
  },
  mounted () {
    this.images = this.value;
  }
}
</script>

<style lang="scss" scoped>
.container {
  @apply relative overflow-hidden bg-blue-10 p-4;

  &:hover {
    @apply bg-blue-20;
  }
}
#file {
  display: none;
}
.image_container {
  @apply flex flex-wrap items-center justify-start;
  border: .15rem dashed hsl(198, 51%, 50%);
}
.image {
  @apply relative overflow-hidden bg-cover;
  width: 192px;
  height: 108px;
  margin: 5px;
}
.reset {
  background: none;
  border: none;
  outline: none;
}
.add {
  @apply cursor-pointer;
  font-size: 40px;
  margin: 10px 20px;
  &:hover {
    @apply text-blue;
  }
  &:active {
    @apply text-orange;
  }
}
.image_button_container {
  @apply flex justify-end;
}
.remove {
  @apply text-white px-2 cursor-pointer top-0 right-0;
  transform: rotate(45deg);
  font-size: 13pt;
  transition-duration: 0.3s;
  text-shadow: 0px 0px 2px white; /* Параметры тени */
  &:hover {
    @apply text-red;
    text-shadow: 0px 0px 2px red; /* Параметры тени */
  }
}
.load {
  @apply cursor-pointer;
  font-size: 14pt;
  transition-duration: 0.3s;
}
.load:hover {
  text-decoration: underline;
}
.loading-container {
  @apply absolute bottom-0 left-0 right-0;
  height: 14px;
}
</style>
