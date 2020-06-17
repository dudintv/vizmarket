<template lang="pug">
.modal-window(v-if="value")
  .hiding-underheath(@click="$emit('input', false)")
  .content
    .close(@click="$emit('input', false)") &times;
    slot
</template>

<script>
export default {
  props: {
    value: Boolean,
  },
}
</script>

<style scoped>
.modal-window {
  /* display: none; */
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;

  display: flex;
  align-items: center;
  justify-content: center;
}

.hiding-underheath {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.8);
  filter: blur(3px);
}

.content {
  @apply bg-body relative;
  z-index: 1100;
}

.close {
  @apply absolute top-0 right-0 px-6 py-2 cursor-pointer bg-blue-10 text-white-50 text-2xl;
  
  &:hover {
    @apply bg-blue-20;
  }
}
</style>