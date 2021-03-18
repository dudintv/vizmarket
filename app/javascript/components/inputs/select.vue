<template lang="pug">
  .form-field
    .field-with-label
      v-select(
        :label="name"
        v-model="selected"
        :options="options"
        :class="{ 'have-selected': selected!='' }"
        multiple
        @input="$emit('input', selected)"
      )
      label(:for="name"): .input-name {{ name }}
    .tip(v-if="$slots['tip']")
      slot(name="tip")
    .error-in-field(v-if="$slots['error']")
      slot(name="error")
</template>

<script>
import vSelect from 'vue-select'

export default {
  components: {
    vSelect,
  },
  props: {
    name: String,
    value: [String, Array],
    options: Array,
  },
  data () {
    return {
      selected: [""],
    }
  },
  watch: {
    value () { this.setSelected() },
  },
  methods: {
    setSelected () {
      this.selected = new Array(this.value).flat() //guarantee an array as input
    }
  }
}
</script>

<style scoped lang="scss">
  @keyframes blink {
    from { border-color: transparent; }
    10% { @apply border-blue-50; }
    to { border-color: transparent; }
  }

  ::v-deep .v-select {
    input[type='search'].vs__search {
      @apply bg-transparent pl-0;
    }
  }

  // .v-select.focused, .v-select.vs--open {
  //   @apply bg-blue-10;
  // }

  .v-select.vs--open, .v-select.have-selected {
    & + label .input-name{
      @apply text-blue;
      transform: translateY(0%) scale(1);
    }

    & + label {
      border-width: 1px;
      border-color: transparent;
      animation: blink 0.5s linear;
    }
  }

  .v-select.vs--open {
    & + label::after{
      @apply text-blue;
      transform: scaleX(1);
    }
  }


  ::v-deep .vs__dropdown-toggle {
    @apply relative bg-blue-10 text-lg;

    &:hover {
      @apply bg-blue-20;
    }

    .vs__selected-options {
      @apply flex items-end pl-4;

      .vs__selected {
        @apply flex px-2 py-0 mb-2 mr-2 fill-current bg-blue-10;
        height: fit-content;

        .vs__deselect {
          @apply p-2 ml-2 mr-0 text-white-50 bg-item-50;
          margin-right: -0.5rem;

          &:hover{
            @apply bg-item text-white;
          }
        }
      }
    }

    .vs__actions {
      @apply absolute top-0 right-0 h-full flex items-center fill-current;
      
      &:hover {
        @apply bg-blue-20;
      }

      .vs__clear {
        @apply p-4 h-full;

        &:hover {
          @apply bg-blue-20;
        }
      }

      .vs__open-indicator {
        @apply m-4;
        transition: all .3s ease;
      }
    }
  }

  ::v-deep .v-select.vs--open {
    .vs__open-indicator {
      transform: rotate(180deg);
    }
  }

  ::v-deep ul.vs__dropdown-menu {
    @apply bg-body-darker absolute w-full shadow-xl;
    top: calc(100% - 2px);
    z-index: 100000;

    li{
      &.vs__dropdown-option {
        @apply p-4;
      }
      
      &.vs__dropdown-option--selected {
        @apply font-bold border-l-2 border-blue text-blue;
      }
      &.vs__dropdown-option--highlight {
        @apply bg-blue-20;
      }
    }
  }
</style>
