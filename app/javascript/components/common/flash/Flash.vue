<template lang="pug">
  .toast.flex.items-center(:class="kind")
    h6.message {{ message }}
    //- CLOSE BUTTON IS HIDED TO AVOID INTERSECTION WITH AUTO-CLOSE
    //- button.close-notification(@click="emit()")
    //-   svg(fill="none" height="27" viewbox=("0 0 26 27") width="26" xmlns="http://www.w3.org/2000/svg")
    //-     line(stroke="white" stroke-opacity="0.5" x1="0.646447" x2="25.6464" y1="25.6464" y2="0.646447")
    //-     line(stroke="white" stroke-opacity="0.5" x1="25.6464" x2="0.646447" y1="26.3536" y2="1.35355")
</template>

<script>
export default {
  props: {
    kind: {
      type: String,
      default: 'notice',
      validator (value) {
        return ['notice', 'warning', 'error', 'alert'].indexOf(value) !== -1
      },
    },
    message: {
      type: String,
      default: '',
    },
  }
}
</script>

<style lang="scss">
@keyframes notification-take-in {
0% {transform:translateY(50px); opacity: 0.5;}
40%{transform:translateY(-2px); opacity: 1;}
100%{transform:translateY(0px);}}

.toast {
  @apply mb-2 border border-white bg-item;
  animation: notification-take-in 2s;
  min-height: 4rem;
  
  transition: box-shadow .2s ease-in-out;

  &.notice {
    @apply border-green;
    box-shadow: 0px 0px 32px theme('colors.green');

    &:hover {
      box-shadow: 0px 0px 32px theme('colors.green-hover'),
                  0px 0px 10px black;
    }
  }

  &.alert, &.warning, &.error {
    @apply border-red;
    box-shadow: 0px 0px 32px theme('colors.red');

    &:hover {
      box-shadow: 0px 0px 32px theme('colors.red-hover'),
                  0px 0px 10px black;
    }
  }

  .message {
    @apply mx-6 my-2 leading-snug;
  }

  // .close-notification {
  //   @apply p-4 h-full;

  //   &:hover {
  //     @apply bg-white-05 fill-white;
  //   }
  // }
}
</style>