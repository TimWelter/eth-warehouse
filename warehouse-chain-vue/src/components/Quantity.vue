<template>
  <v-card>
    <v-card-title
      >{{ checkIn ? "Check in" : "Check out" }} {{ product.name }} {{product.id}}</v-card-title
    >
    <v-card-text>
      <v-form v-model="valid">
        <v-container>
          <v-text-field
            v-model="quantity"
            label="Hoeveelheid"
            required
            :rules="!checkIn ? quantityRules : []"
          ></v-text-field>
        </v-container>
      </v-form>
    </v-card-text>
    <v-card-actions>
        <v-spacer></v-spacer>
      <v-btn :disabled="!valid" color="primary" text @click.prevent="onSubmit()">Doorgaan</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex";

export default {
    props: ['checkIn', 'product'],
    data () {
        return {
            quantity: 0,
            quantityRules: [v => v <= this.product.quantity || "Not enough in store"],
            valid: false
        }
    },
    computed: {
        ...mapGetters("drizzle", ["drizzleInstance"]),
        utils() {
            return this.drizzleInstance.web3.utils;
        },
        quantityMethod() {
            return this.checkIn ? "checkInProduct" : "checkOutProduct"
        }
    },

    methods: {
        onSubmit() {
        this.drizzleInstance.contracts["Warehouse"].methods[this.quantityMethod].cacheSend(
            this.product.id,
            this.quantity
        );
        this.$emit("quantity-done")
        },
  },
};

</script>

<style>
</style>