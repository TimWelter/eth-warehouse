<template>
  <v-app>
    <div>
      <v-toolbar color="blue">
        <div title="Connection" class="dot" :class="isDrizzleInitialized ? 'connected-dot' : 'disconnected-dot'"></div>
        <v-toolbar-title>
          <account @no-username="openChooseUsername()"></account>
        </v-toolbar-title>
      </v-toolbar>
    </div>
      <div>
        <router-view></router-view>
      </div>
      <v-dialog v-model="dialog" width="500">
          <choose-username @username="closeChooseUsername()"></choose-username>
        </v-dialog>
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import ChooseUsername from './components/ChooseUsername.vue';
export default {
  components: { ChooseUsername },
  name: "App",

  data: () => ({
    dialog: false
  }),
  computed: mapGetters("drizzle", ["isDrizzleInitialized"]),
  methods: {
    openChooseUsername() {
      this.dialog = true;
    },
    closeChooseUsername() {
      this.dialog = false
    }
  }
};
</script>

<style>
  .dot {
    height: 20px;
    width: 20px;
    border-radius: 100%;
    margin-right: 15px;

  }

  .connected-dot {
    background-color: green;
  }

  .disconnected-dot {
    background-color: red;
  }
</style>