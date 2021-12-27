<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>
    <v-col cols=12>
      <h1 class="text-center">作品一覧</h1>
      <v-divider class="my-3"></v-divider>
    </v-col>
    <v-col cols=12 v-for="repo in repositories" v-bind:key="repo.title">
      <v-card
        class="mx-auto"
        max-width="100%"
        elevation="2"
        @click="moveToRepositoryDetail(repo.id);"
      >
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title class="headline mb-1">
              {{repo.title}}
            </v-list-item-title>
            <v-list-item-subtitle>
              {{repo.description}}
            </v-list-item-subtitle>
            
          </v-list-item-content>
        </v-list-item>
        <v-col>
          <v-row
            align="center"
            justify="end"
          >
            <span class="subheading mr-4">作成者：{{repo.user_name}}</span>
            <span class="subheading mr-2">作成日：{{$dayjs(repo.created_at).format("YYYY/MM/DD")}}</span>
          </v-row>
        </v-col>
      </v-card>
    </v-col>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default Vue.extend({
  name: "home",
  data(){
    return {
      repositories: [],
      isProcessing: false,
    }
  },
  components: {
    Loading,
  },
  methods: {
    moveToRepositoryDetail: function (repo_id){
      this.$router.push({ name: 'repositoryDetail', params: { repository_id: repo_id }});
    },
  },
  mounted: function(){
    this.isProcessing = true;
    this.axios
      .get("http://localhost:3000/api/v1/content/repositories_with_user")
      .then((res) => {
        this.repositories = res.data;
        this.isProcessing = false;
        console.log(res.data);
      })
      .catch((e) => {
        alert(e);
      });
  }
});
</script>