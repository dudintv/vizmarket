<template lang="pug">
  //- forked from https://github.com/d-shorkin/vue-files-dropper
  div(
    :class="classes"
      @click="onClick"
      @mouseover="hover = true"
      @mouseleave="hover = false"
      @drop.prevent="onDrop"
      @dragover.prevent="hover = true"
      @dragleave.prevent="hover = false"
  )
    .border
      button.v-files-dropper__clear(
        type="button"
        @click.stop="onClear"
        v-if="canClear"
      ) remove all
      slot
      input(
        type="file"
        ref="input"
        :disabled="disabled"
        :multiple="multiple"
        :accept="accept"
        @change="onChange" 
      )
</template>

<script>
  export default {
    name: "VueFilesDropper",
    props: {
      placeholder: String,
      value:{},
      multiple: Boolean,
      disabled: Boolean,
      accept: {
        type:String,
        default: '*/*'
      }
    },
    data: ()=>({
      hover: false
    }),
    computed: {
      classes(){
        let classes = ['v-files-dropper'];

        if(this.hover)
          classes.push('hover');

        if(this.disabled)
          classes.push('disabled');

        if( this.hover && this.disabled )
          classes.push('error');

        return classes;
      },
      acceptMimes(){
        return this.accept.split(',').map(item=>item.trim().split('/'));
      },
      canClear(){
        if(this.disabled)
          return false;

        if(this.multiple && this.value.length)
          return true;

        return !!(!this.multiple && this.value);
      }
    },
    methods:{
      onChange(e){
        this.emit(Array.from(e.target.files));
        this.$emit('change');
      },
      onDrop(e){
        this.emit(Array.from(e.dataTransfer.files));
        this.$emit('change');
        this.hover = false;
      },
      onClick(e){
        if(this.disabled)
          return;

        this.$refs.input.click();
        this.$emit('click', e)
      },
      onClear(){
        if(this.canClear)
          this.clear();
      },
      clear(){
        this.resetInput();
        if(this.multiple && this.value.length){
          this.$emit('input', [] );
          this.$emit('change');
        }else if(!this.multiple && this.value){
          this.$emit('input', null);
          this.$emit('change');
        }
      },
      resetInput(){
        const input = this.$refs.input;
        input.type = 'text';
        input.type = 'file';
      },
      emit(files){
        if(!this.filesAccept(files))
          return false;

        if(!this.multiple)
          return this.$emit('input', files[0]);

        if(!this.value)
          return this.$emit('input', files );

        return this.$emit('input', Array.from(files) );
      },
      filesAccept(files){
        return files.every((file)=>{
          let type = file.type.split('/');
          return this.acceptMimes.some((accepted)=>{
            if(
              accepted[0] === '*' ||
              (accepted[0] === type[0] && accepted[1] === '*') ||
              (accepted[0] === type[0] && accepted[1] === type[1])
            ){
              return true;
            }

            let error = new Error(`File ${file.name} has not accepted type ${file.type}`);
            this.$emit('error',error);
            throw error;
          });
        });
      }
    }
  }
</script>

<style lang="scss" scoped>
  .v-files-dropper{
    @apply bg-pale-blue-10 p-4 cursor-pointer w-full text-lg;

    .border{
      @apply relative w-full flex justify-center items-center p-4;
      border: .15rem dashed hsl(198, 51%, 50%);
      min-height: 6em;
    }

    &.disabled{
      cursor: default;
      color: lightgray;
      border-color: rgba(lightgray, .5);
    }

    &:not(.disabled){
      &:hover, &.hover{ @apply bg-pale-blue-20; }
    }

    &.error{cursor: not-allowed}

    &__clear{
      @apply absolute right-4 top-4 cursor-pointer outline-none text-light-blue;
      &:hover {
        @apply text-white;
      }
    }

    input{ display: none; }
  }
</style>