<template>
  <div>
    <h1>この画面は開発者用です．この画面が出ているのはおかしくないですか？</h1>
    <p><router-link to="/">Home</router-link></p>
    <p><router-link to="/shabon_description">ShabonDescription</router-link></p>
    <p><router-link to="/terms_of_service">TermsOfService</router-link></p>
    <p><router-link to="/repository_creation/1">RepositoryCreation</router-link></p>
    <p><router-link to="/repository_detail/1">RepositoryDetail</router-link></p>
    <p><router-link to="/chapter_creation">ChapterCreation</router-link></p>
    <p><router-link to="/chapter_detail/1">ChapterDetail</router-link></p>
    <p><router-link to="/mypage">MyPage</router-link></p>
    <p><router-link to="/fishers_debug">Debug</router-link></p>
    <router-view></router-view>

  </div>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "debug",
});
</script>