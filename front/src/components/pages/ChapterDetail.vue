<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-row class="mx-1 mt-5 mb-3">
      <v-btn elevation="2" @click="moveToRepositoryDetail();">←作品ページへ</v-btn>
    </v-row>
    <v-row class="text-center">
      <v-col cols=12>
        <h3 v-if="repository !== null">{{chapter.repository_title}}</h3>
        <h1 v-if="chapter !== null">{{chapter.title}}</h1>
        <v-row justify="end" class="mt-1 mr-1" >
          <h3 v-if="chapter !== null">閲覧数：{{chapter.view}}</h3>
        </v-row>
        <v-divider class="my-3"></v-divider>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12>
        <p v-if="chapter !== null" style="white-space: pre-wrap;" v-text="chapter.text"></p>
        <v-divider class="my-5"></v-divider>
      </v-col>
    </v-row>
    <v-row v-if="chapter !== null" class="mt-1 mb-5 mx-1">
      <v-btn v-if="0 < $route.params.chapter_index" elevation="2" color="primary" @click="moveToPreviousChapter();">←前のチャプターへ</v-btn>
      <v-spacer></v-spacer>
      <v-btn v-if="$route.params.chapter_index + 1 < chapters.length" elevation="2" color="primary" @click="moveToNextChapter();">次のチャプターへ→</v-btn>
    </v-row>
    </v-container>    
</template>

<script lang="ts">
import Vue from "vue";
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default Vue.extend({
  name: "chapterDetail",
  data(){
    return{
      isProcessing: false,
      chapter: null,
      chapters: [],
    };
  },
  mounted: async function(){
    this.fetchItems();
  },
  methods: {
    fetchItems: async function(){
      this.isProcessing = true;
      try{
        //チャプタリストの取得後に閲覧チャプタの詳細を取得
        const axiosChapsInfo = await this.axios.get(`http://localhost:3000/api/v1/content/chapters_in_repository/${this.$route.params.repository_id}`);
        this.chapters = axiosChapsInfo.data;
        const axiosChapInfo = await this.axios.get(`http://localhost:3000/api/v1/content/chapter_with_repository/${this.chapters[this.$route.params.chapter_index].id}`);
        this.chapter = axiosChapInfo.data;

        //チャプタの閲覧数をインクリメント
        this.chapter.view++;
        const axiosChapUpdate = await this.axios.patch(`http://localhost:3000/api/v1/content/chapters/${this.chapter.id}`,this.chapter);
      }catch(e){
        alert(e);
      }finally{
        this.isProcessing = false;
      }
    },
    moveToRepositoryDetail: function(){
      this.$router.push({ name: 'repositoryDetail', params: { repository_id: this.$route.params.repository_id }});
    },
    moveToPreviousChapter: function(){
      this.$router.push({ name: 'chapterDetail', params: { repository_id: this.$route.params.repository_id, chapter_index: this.$route.params.chapter_index - 1 }});
    },
    moveToNextChapter: function(){
      this.$router.push({ name: 'chapterDetail', params: { repository_id: this.$route.params.repository_id, chapter_index: this.$route.params.chapter_index + 1 }});
    },
  },
  watch: {
    $route: function(to, from){
      this.fetchItems();
    }
  }
});
</script>