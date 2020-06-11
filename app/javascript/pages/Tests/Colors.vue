<template lang="pug">
#test-color-page
  br
  br
  .flex
    .texts
      h2.text-red Red
      p.text-red Red text text text
      h2.text-red-hover Red-hover
      p.text-red-hover Red-hover text text text
      h2.text-orange Orange
      p.text-orange Orange text text text
      h2.text-orange-hover Orange-hover
      p.text-orange-hover Orange-hover text text text
      h2.text-blue Pale blue
      p.text-blue Pale blue text text text
      h2.text-light-blue Light blue
      p.text-light-blue Light blue text text text
      h2.text-lime Lime
      p.text-lime Lime text text text
      h2.text-green Green
      p.text-green Green text text text

      h2.text-white White
      p.text-white White text text text
      h2.text-white-on-black White-on-black
      p.text-white-on-black White-on-black text text text
      h2.text-white-80 White-80
      p.text-white-80 White-80 text text text
      h2.text-white-50 White-50
      p.text-white-50 White-50 text text text
      h2.text-white-20 White-20
      p.text-white-20 White-20 text text text
      h2.text-white-05 White-05
      p.text-white-05 White-05 text text text
      h2.text-white-03 White-03
      p.text-white-03 White-03 text text text

    #space.w-1_6
    .bgs
      .bg-red.flex.justify-between
        .text-white White text on red
        .text-black Black text on red
      | &nbsp;
      .bg-orange.flex.justify-between
        .text-white White text on orange
        .text-black Black text on orange
      | &nbsp;
      .bg-blue.flex.justify-between
        .text-white White text on blue
        .text-black Black text on blue
      | &nbsp;
      .bg-light-blue.flex.justify-between
        .text-white White text on light-blue
        .text-black Black text on light-blue
      | &nbsp;
      .bg-lime.flex.justify-between
        .text-white White text on lime
        .text-black Black text on lime
      | &nbsp;
      .bg-green.flex.justify-between
        .text-white White text on green
        .text-black Black text on green
      | &nbsp;

      .bg-body.flex.justify-between
        .text-white White text body
        .text-black Black text body
      | &nbsp;
      .bg-body-darker.flex.justify-between
        .text-white White text body-darker
        .text-black Black text body-darker
      | &nbsp;
      .bg-item.flex.justify-between
        .text-white White text item
        .text-white-on-black White-on-black text
        .text-black Black text item
      | &nbsp;
      .bg-item-darker.flex.justify-between
        .text-white White text item-darker
        .text-white-on-black White-on-black text
        .text-black Black text item-darker
      | &nbsp;
      .bg-item-gray.flex.justify-between
        .text-white White text item-gray
        .text-black Black text item-gray
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>

</style>