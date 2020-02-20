<template lang="pug">
  //- forked from https://www.npmjs.com/package/vue-picture-upload
  .container
    .image_container
      .image(v-for="i in Images" :key="i[keyName]" :style="GetStyle(i[valueName])")
        .image_button_container
          button.reset.remove(@click="Remove(i)") +
      template(v-if="preLoaded.length > 0")
        .image(v-for="i in preLoaded" :key="i.name" :style="GetStyle(i.image)")
          .image_button_container
            button.reset.remove(@click="RemoveFromBufer(i)") +
        //- button.reset.load(@click="Upload()") Upload
      input(type="file" id="file" ref="file" :accept="accept" :multiple="multiple" v-on:change="handleFileUpload()")
      button.add.reset.flex-grow(@click="Select()") +
</template>
<script>
export default {
  props: {
    Images: {
      type: Array,
      required: true
    },
    keyName: {
      type: String,
      required: true
    },
    valueName: {
      type: String,
      required: true
    },
    multiple: {
      type: Boolean,
      default: true
    },
    accept: {
      type: String,
      default: ".jpg, .png, .svg"
    }
  },
  data: () => ({
    preLoaded: []
  }),
  computed: {
    allImages: function () {
      return this.Images.concat(this.preLoaded)
    }
  },
  methods: {
    Select() {
      this.$refs.file.click();
    },
    Remove(e) {
      this.$emit("remove", e[this.keyName]);
      const index = this.Images.indexOf(
        this.Images.filter(el => el[this.keyName] === e[this.keyName])[0]
      );
      if (index || index === 0) {
        this.Images.splice(index, 1);
      }
    },
    RemoveFromBufer(e) {
      const index = this.preLoaded.indexOf(
        this.preLoaded.filter(el => el.name === e.name)[0]
      );
      if (index || index === 0) {
        this.preLoaded.splice(index, 1);
      }
    },
    // Upload() {
    //   Array.from(this.preLoaded).forEach(el => {
    //     this.$emit("upload", el.image);
    //   });
    //   this.preLoaded = [];
    // },
    async handleFileUpload() {
      const files = this.$refs.file.files;
      Array.from(files).forEach(file => {
        const reader = new FileReader();
        reader.onload = e => {
          this.preLoaded.push({ image: e.target.result, name: file.name });
        };
        reader.readAsDataURL(file);
      });
    },
    GetStyle(image) {
      return {
        "background-image": "url(" + image + ")"
      };
    },
  },
  watch: {
    Images:    function () { this.$emit( 'input', this.allImages ) },
    preLoaded: function () { this.$emit( 'input', this.allImages ) },
  },
  name: "vue-picture-upload"
};
</script>
<style scoped lang="scss">
.container {
  @apply bg-blue-10 p-4;

  &:hover {
    @apply bg-blue-20;
  }
}

#file {
  display: none;
}
.image_container {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-items: center;

  border: .15rem dashed hsl(198, 51%, 50%);
}
.image {
  width: 192px;
  height: 108px;
  margin: 5px;
  background-size: cover;
}
.reset {
  background: none;
  border: none;
  outline: none;
}
.add {
  cursor: pointer;
  font-size: 40px;
  margin: 10px 20px;
  &:hover {
    @apply text-blue;
  }
  &:active {
    color: lightcoral;
  }
}
.image_button_container {
  // background: rgba(17, 16, 16, 0.137);
  display: flex;
  justify-content: flex-end;
}
.remove {
  @apply text-white px-2;
  top: 0px;
  right: 0px;
  transform: rotate(45deg); /* Standard syntax */
  cursor: pointer;
  font-size: 13pt;
  transition-duration: 0.3s;
  text-shadow: 0px 0px 2px white; /* Параметры тени */
  &:hover {
    @apply text-red;
    text-shadow: 0px 0px 2px red; /* Параметры тени */
  }
}
.load {
  font-size: 14pt;
  cursor: pointer;
  transition-duration: 0.3s;
}
.load:hover {
  text-decoration: underline;
}
</style>