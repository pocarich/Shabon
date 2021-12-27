import Vue from "vue";
import App from "./App.vue";
import vuetify from "./plugins/vuetify";
import router from "./router";
import axios from "axios";
import VueAxios from "vue-axios";
import dayjs from "dayjs";

dayjs.locale("ja");
Vue.prototype.$dayjs = dayjs;

Vue.config.productionTip = false;
Vue.use(VueAxios, axios);

new Vue({
  router,
  vuetify,
  render: (h) => h(App),
}).$mount("#app");
