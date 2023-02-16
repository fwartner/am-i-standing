<!-- Please remove this file from your project -->
<template>
  <div
    class="
      relative
      flex
      items-top
      justify-center
      min-h-screen
      bg-gray-100
      sm:items-center sm:pt-0
    "
  >
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css"
      rel="stylesheet"
    >
    <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
      <div v-if="isStanding" class="mt-8 bg-white overflow-hidden shadow sm:rounded-lg p-6">
        <h2 class="text-2xl leading-7 font-semibold">
          Florian is standing in front of his desk
        </h2>
      </div>
      <div v-else class="mt-8 bg-white overflow-hidden shadow sm:rounded-lg p-6">
        <h2 class="text-2xl leading-7 font-semibold">
          Florian is not standing in front of his desk. He is probably sitting on the couch.
        </h2>
      </div>
    </div>
  </div>
</template>

<script>
const data = {
  query: `
    query {
        home {
          isStanding
        }
    }
  `
}

const headers = {
  headers: {
    'Content-Type': 'application/json'
  }
}

export default {
  name: 'CurrentlyPlaying',
  data () {
    return {
      isStanding: false
    }
  },

  mounted () {
    this.getData()
    this.getTimer()
  },

  methods: {
    getTimer () {
      window.setInterval(() => {
        this.getData()
      }, 3600)
    },

    getData () {
      this.$axios
        .$post('https://api.wartner.io', data, headers)
        .then((response) => {
          if (response.data.home.isStanding === true) {
            this.isStanding = true
          }
        })
    }
  }
}
</script>
