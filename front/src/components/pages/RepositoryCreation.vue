<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-col cols=12>
      <h1 class="text-center">作品ページ作成</h1>      
      <v-divider class="my-3"></v-divider>
      <v-text-field
          label="作品名"
          placeholder="作品名を入力"
          counter="30"
          hint="最大30文字"
          color="primary"
          maxlength="30"
          outlined
          v-model="title"
        ></v-text-field>
      <v-text-field
          label="概要"
          placeholder="作品の簡単な概要を入力"
          counter="50"
          hint="最大50文字"
          color="primary"
          maxlength="50"
          outlined
          v-model="description"
        ></v-text-field>
      <v-textarea
          label="詳細説明"
          placeholder="作品の詳細説明を入力"
          counter="400"
          hint="最大400文字"
          color="primary"
          maxlength="400"
          outlined
          v-model="detail"
        ></v-textarea>
      <v-row justify="end">
        <v-btn elevation="3" class="mx-3 my-3" color="primary" @click="upload();">作成</v-btn>
      </v-row>
    </v-col>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default Vue.extend({
  data: function () {
    return {
      title: "",
      description: "",
      detail: "",
      isProcessing: false,
    };
  },
  components: {
    Loading,
  },
  methods: {
    upload: function () {
      if (!this.title){
        alert("作品名を入力してください！！");
      }
      else{
        this.isProcessing = true;
        this.axios
        .post("http://localhost:3000/api/v1/content/repositories", {
          title: this.title,
          description: this.description,
          detail: this.detail,
          user_id: 1,
        })
        .then((res) => {
          alert("作品ページを作成しました！");
          this.$router.push({ name: 'repositoryDetail', params: { repository_id: res.data.id }});
        })
        .catch((e) => {
          alert(e);
          this.isProcessing = false;
        });
      }
    },
    onCancel: function () {
      console.log('User cancelled the loader.')
    },
  },
});
</script>