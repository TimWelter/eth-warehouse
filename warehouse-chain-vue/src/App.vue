<template>
  <v-app>
    <div>
      <v-toolbar :color="isDrizzleInitialized ? 'blue' : 'red'">
        <v-toolbar-title>
          <drizzle-account units="Ether" :precision="2"></drizzle-account>
        </v-toolbar-title>
      </v-toolbar>
    </div>
      <div>
        <router-view></router-view>
      </div>
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "App",

  data: () => ({}),
  computed: mapGetters("drizzle", ["isDrizzleInitialized"]),
};
</script>
