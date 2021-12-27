<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-row class="mx-1 mt-5 mb-3">
      <v-btn elevation="2" @click="moveToRepositoryEdit();">←作品ページ編集画面へ</v-btn>
    </v-row>    
    <v-col cols=12>
      <h1 class="text-center">チャプター作成</h1>      
      <v-divider class="my-3"></v-divider>
      <v-text-field
        label="チャプター名"
        placeholder="チャプター名を入力"
        counter="30"
        hint="最大30文字"
        color="primary"
        maxlength="30"
        outlined
        v-model="title"
      ></v-text-field>
      <v-textarea
        label="本文"
        placeholder="本文を入力"
        counter="50000"
        hint="最大50000文字"
        color="primary"
        maxlength="50000"
        outlined
        rows="12"
        v-model="text"
      ></v-textarea>
      <v-row justify="end">
        <v-btn elevation="3" class="mx-3 my-3" color="primary" @click="upload();">作成</v-btn>
      </v-row>
    </v-col>
  </v-container>
</template>

<script lang = "ts">
import Vue from "vue";
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default Vue.extend({
  name: "chapterEdit",
  data(){
    return{
      title: "",
      text: "",
    }
  },

  methods: {
    moveToRepositoryEdit: function(){
      this.$router.push({ name: 'repositoryEdit', params: { edit_repository_id: this.$route.params.repository_id }});
    },
    upload: function () {
      if (!this.title){
        alert("チャプター名を入力してください！！");
      }
      else{
        this.isProcessing = true;
        this.axios
        .post("http://localhost:3000/api/v1/content/chapters", {
          title: this.title,
          text: this.text,
          repository_id: this.$route.params.repository_id
        })
        .then((res)=>{
          alert("新規チャプターを作成しました！");
          this.isProcessing = false;
          this.$router.push({ name: 'repositoryEdit', params: { edit_repository_id: this.$route.params.repository_id }});
        })
        .catch((e)=>{
          alert(e);
        });
      }
    },
  },
})
</script>