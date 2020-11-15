import Vue from 'vue'
import App from './App.vue'
import router from './router'
import vuetify from './plugins/vuetify';
import store from './store'

import drizzleVuePlugin from '@drizzle/vue-plugin'
import drizzleOptions from '../drizzleOptions'

import ProductList from "./components/ProductList.vue"
import Account from "./components/Account.vue"
import AddProduct from "./components/AddProduct.vue"
import ChooseUsername from "./components/ChooseUsername.vue"
import Quantity from "./components/Quantity.vue"


Vue.config.productionTip = false

Vue.use(drizzleVuePlugin, { store, drizzleOptions })

Vue.component("product-list", ProductList)
Vue.component("account", Account)
Vue.component("add-product", AddProduct)
Vue.component("choose-username", ChooseUsername)
Vue.component("quantity", Quantity)


new Vue({
  router,
  vuetify,
  store,
  render: h => h(App)
}).$mount('#app')
