<template>
  <div>
    <v-card class="ma-2">
      <v-card-title>
        <div class="mr-5">Products</div>
        <v-text-field v-model="search" label="Search" class="mx-4 px-5">
        </v-text-field>

        <v-dialog v-model="addProductDialog" width="500">
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              color="primary"
              elevation="2"
              x-large
              icon
              v-bind="attrs"
              v-on="on"
              ><v-icon>mdi-book-plus</v-icon></v-btn
            >
          </template>

          <add-product @add-product="onNewProduct()"></add-product>
        </v-dialog>
        <v-dialog v-model="quantityDialog" width="500"> 
          <quantity :product="selectedProduct" @quantity-done="closeQuantityDialog()" :checkIn="checkIn" ></quantity>
        </v-dialog>
      </v-card-title>
      <v-data-table
        :loading="!isDrizzleInitialized"
        :headers="headers"
        :items="products"
        item-key="id"
        :search="search"
      >
        <template v-slot:item.actions="{ item }">
          <v-btn small class="mx-1" color="red" @click="openQuantityDialog(false, item)"> Check out</v-btn>
          <v-btn small class="mx-1" color="blue" @click="openQuantityDialog(true, item)"> Check in</v-btn>
        </template>
      </v-data-table>
    </v-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Quantity from './Quantity.vue';
const getProductArgs = {
  contractName: "Warehouse",
  method: "getAllProducts",
  methodArgs: "",
};
export default {
  components: { Quantity },
  name: "product-list",
  data() {
    return {
      products: [],
      search: "",
      addProductDialog: false,
      quantityDialog: false,
      checkIn: false,
      selectedProduct: null
    };
  },
  methods: {
    onNewProduct() {
      this.addProductDialog = false
    },
    openQuantityDialog(checkIn, product) {
      this.checkIn = checkIn
      this.selectedProduct = product
      this.quantityDialog = true
    },
    closeQuantityDialog() {
      this.quantityDialog = false;
    }
    
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    ...mapGetters("contracts", ["getContractData"]),
    utils() {
      return this.drizzleInstance.web3.utils
    },
    productData() {
      return this.getContractData({
        contract: getProductArgs.contractName,
        method: getProductArgs.method,
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
        { text: 'Actions', value: 'actions', sortable: false },

      ];
    },
  },

  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", getProductArgs);
  },
  watch: {
    productData: function () {
      // if (oldData == "loading" || newData.length == oldData.length + 1 || oldData !== newData) {
        this.products = []
        this.productData.forEach((product) => {
          this.products.push({
            id: product[0],
            name: this.utils.toAscii(product[1]),
            quantity: product[2],
            location: product[3][0] + this.utils.toAscii(product[3][1]),
          });
        });
      // }
    },
  },
};
</script>

<style>
</style>