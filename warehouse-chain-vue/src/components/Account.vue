<template>
  <div>
    <div>{{ username }}</div>
  </div>
</template>

<script>
import  { mapGetters } from "vuex"
const args = {
  contractName: "Warehouse",
  method: "getUsername",
  methodArgs: "",
};
export default {
    name: "account",
    data () {
        return {
            username: null
        }
    },
    computed: {
        ...mapGetters("contracts", ["getContractData"]),
        ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),

        utils() {
            return this.drizzleInstance.web3.utils
        },
        contractData() {
            let data = this.getContractData({
                contract: args.contractName,
                method: args.method,
            });
            console.log(data)
            return data
        }
    },
    created() {
        this.$store.dispatch("drizzle/REGISTER_CONTRACT", args);
    },
    watch: {
        contractData: function (newData) {
        this.username = this.utils.toAscii(newData)
        console.log(this.username)
        if(newData == 0x00000000000000000000000000000000) {
            this.$emit("no-username")
        }
    }   
    },

    

}
</script>

<style>
</style>