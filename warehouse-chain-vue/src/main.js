import Vue from 'vue'
import App from './App.vue'
import router from './router'
import vuetify from './plugins/vuetify';
import store from './store'

import drizzleVuePlugin from '@drizzle/vue-plugin'
import drizzleOptions from '../drizzleOptions'

import ProductList from "./components/ProductList.vue"


Vue.config.productionTip = false

Vue.use(drizzleVuePlugin, { store, drizzleOptions })

Vue.component("ProductList", ProductList)


new Vue({
  router,
  vuetify,
  store,
  render: h => h(App)
}).$mount('#app')
