<template>
  <v-card>
    <v-card-title class="headline grey lighten-2">Add product </v-card-title>
    <v-divider></v-divider>
    <v-card-text>
      <v-form v-model="valid">
        <v-container>
              <v-text-field
                v-model="username"
                label="Gebruikersnaam"
                required
              ></v-text-field>
        </v-container>
      </v-form>
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary" text @click.prevent="onSubmit()">Kies</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "choose-username",
  data: () => ({
    username: "",

  }),
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
    utils() {
      return this.drizzleInstance.web3.utils;
    },
  },
  methods: {
    onSubmit() {
      this.drizzleInstance.contracts["Warehouse"].methods[
        "chooseUsername"
      ].cacheSend(
        this.utils.toHex(this.username),
      );
      this.$emit("username")
    },
  },
};
</script>

<style>
</style>