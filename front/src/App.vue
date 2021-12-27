<template>
  <v-app>
    <v-app-bar app>
      <v-toolbar-title>Shabon</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-sm-and-down">
        <v-btn text to="/">ホーム</v-btn>
        <v-btn text to="/repository_creation">作品作成</v-btn>
      </v-toolbar-items>
    </v-app-bar>
    
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "app",
});
</script>
