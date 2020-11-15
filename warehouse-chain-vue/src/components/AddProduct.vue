<template>
  <v-card>
    <v-card-title class="headline grey lighten-2">Add product </v-card-title>
    <v-divider></v-divider>
    <v-card-text>
      <v-form v-model="valid">
        <v-container>
          <v-row>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="productName"
                label="Product name"
                required
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="6">
              <v-text-field
                v-model="productQuantity"
                label="Hoeveelheid"
                required
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="locationNumber"
                label="Locatie nummer"
                required
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="6">
              <v-text-field
                v-model="locationLetter"
                label="Locatie letter"
                required
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary" text @click.prevent="onSubmit()">Toevoegen</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  name: "add-product",
  data: () => ({
    productName: "",
    productQuantity: "",
    locationNumber: null,
    locationLetter: "",
    valid: false,
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
        "addProduct"
      ].cacheSend(
        this.utils.toHex(this.productName),
        parseInt(this.productQuantity),
        parseInt(this.locationNumber),
        this.utils.toHex(this.locationLetter)
      );
      this.$emit("add-product")
    },
  },
};
</script>

<style>
</style>