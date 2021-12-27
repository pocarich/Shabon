<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-row class="mx-1 mt-5 mb-3">
      <v-btn elevation="2" @click="moveToRepositoryEdit();">←作品ページ編集画面へ</v-btn>
    </v-row>    
    <v-col cols=12>
      <h1 class="text-center">チャプター編集</h1>      
      <v-divider class="my-3"></v-divider>
      <v-text-field
        label="チャプター名"
        placeholder="チャプター名を入力"
        counter="30"
        hint="最大30文字"
        color="primary"
        maxlength="30"
        outlined
        v-model="chapter.title"
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
        v-model="chapter.text"
      ></v-textarea>
      <v-row justify="end">
        <v-btn elevation="3" class="mx-3 my-3" color="primary" @click="saveChapter();">保存</v-btn>
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
      isProcessing: false,
      chapter: null,
    }
  },

  mounted: function () {
    this.isProcessing = true;
    this.axios
    .get(`http://localhost:3000/api/v1/content/chapters/${this.$route.params.edit_chapter_id}`)
    .then((res) => {
      this.chapter = res.data;
      this.isProcessing = false;
    })
    .catch((e) => {
      alert(e);
    });
  },

  methods: {
    moveToRepositoryEdit: function(){
      this.$router.push({ name: 'repositoryEdit', params: { edit_repository_id: this.$route.params.repository_id }});
    },
    saveChapter: function () {
      if (!this.chapter.title){
        alert("チャプター名を入力してください！！");
      }
      else{
        this.isProcessing = true;
        this.axios
        .patch(`http://localhost:3000/api/v1/content/chapters/${this.$route.params.edit_chapter_id}`,this.chapter)
        .then((res)=>{
          alert("編集内容を保存しました！");
          this.isProcessing = false;
        })
        .catch((e)=>{
          alert(e);
        });
      }
    },
  },
})
</script>