<template>
  <div>
    <v-data-table
      :headers="headers"
      :items="products"
      item-key="name"
    ></v-data-table>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import util from "../util/util"
const args = {
  contractName: "Warehouse",
  method: "getAllProducts",
  methodArgs: "",
};
export default {
  name: "ProductList",
  data() {
    return {
      products: [],
    };
  },
  computed: {
    ...mapGetters("contracts", ["getContractData"]),

    contractData() {
      return this.getContractData({
        contract: args.contractName,
        method: args.method,
      });
    },

    headers() {
      return [
        {
          text: "Naam",
          align: "start",
          value: "name",
        },
        {
          text: "Hoeveelheid",
          sortable: false,
          value: "quantity",
        },
        {
          text: "Locatie",
          value: "location",
        },
      ];
    },
  },
  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", args);
  },
  watch: {
    contractData: function (newData, oldData) {
      if (oldData == "loading") {
        this.contractData.forEach((product) => {
          this.products.push({
            name: util.hexToAscii(product[0]),
            quantity: product[1],
            location: product[2][0] + util.hexToAscii(product[2][1]),
          });
        });
      }
    },
  },
};
</script>

<style>
</style>