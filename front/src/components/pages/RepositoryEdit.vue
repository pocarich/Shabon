<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-btn elevation="2" class="mx-1 mt-5 mb-3" @click="moveToDetail();">←作品ページに戻る</v-btn>
    <v-col cols=12>
      <h1 class="text-center">作品ページ編集</h1>      
      <v-divider class="my-3"></v-divider>
      <v-text-field
        label="作品名"
        placeholder="作品名を入力"
        counter="30"
        hint="最大30文字"
        color="primary"
        maxlength="30"
        outlined
        v-model="repository.title"
      ></v-text-field>
      <v-text-field
        label="概要"
        placeholder="作品の簡単な概要を入力"
        counter="50"
        hint="最大50文字"
        color="primary"
        maxlength="50"
        outlined
        v-model="repository.description"
      ></v-text-field>
      <v-textarea
        label="詳細説明"
        placeholder="作品の詳細説明を入力"
        counter="400"
        hint="最大400文字"
        color="primary"
        maxlength="400"
        outlined
        v-model="repository.detail"
      ></v-textarea>
      <v-row justify="end">
        <v-btn elevation="3" class="mx-3 my-3" color="primary" @click="saveInfo();">保存</v-btn>
      </v-row>
    </v-col>
      
    <h2 class="text-center mt-10">チャプター一覧</h2>
    <v-divider class="my-3"></v-divider>
    <v-col
      v-for="(chap, index) in chapters" 
      v-bind:key="chap.title"
    >
      <v-col cols=12>
        <v-card
          elevation="2"
          @click="moveToChapterView(index);"
        >
          <v-card-title>{{chap.title}}</v-card-title>
        </v-card>
      </v-col>
      <v-row justify="end" class="mr-1" >
        <v-btn class="ma-2" color="primary" dark @click="moveToChapterEdit(chap.id);">編集</v-btn>
        <v-btn class="ma-2" color="red" dark @click="deleteChapter(chap.id);">削除</v-btn>
      </v-row>
    </v-col>
    <v-col v-if="chapters.length === 0" class="text-center" cols=12>
      <h3>現在チャプターは投稿されていません。</h3>
    </v-col>
    <v-col cols=12>
      <v-divider class="my-1"></v-divider>
      <v-row justify="end" class="mx-1 mt-5">
        <v-btn color="success" class ="mb-5" dark @click="moveToChapterCreation();">新規チャプター作成</v-btn>
      </v-row>
    </v-col>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default Vue.extend({
  name: "repositoryEdit",
  data: function () {
    return {
      repository: null,
      chapters: [],
      isProcessing: false,
    };
  },
  components: {
    Loading,
  },
  mounted: async function(){
    this.isProcessing = true;
    try{
      //repoInfoとchapInfoの取得を並列処理
      const axiosRepoInfo = this.axios.get(`http://localhost:3000/api/v1/content/repositories/${this.$route.params.edit_repository_id}`);
      const axiosChapInfo = this.axios.get(`http://localhost:3000/api/v1/content/chapters_in_repository/${this.$route.params.edit_repository_id}`);

      const repoInfo = await axiosRepoInfo;
      const chapInfo = await axiosChapInfo;
      this.repository = repoInfo.data;
      this.chapters = chapInfo.data;
    }catch(e){
      alert(e);
    }finally{
      this.isProcessing = false;
    }
  },
  methods: {
    moveToDetail: function (){
      this.$router.push({ name: 'repositoryDetail', params: { repository_id: this.$route.params.edit_repository_id }});
    },
    saveInfo: function () {
      if (!this.repository.title){
        alert("作品名を入力してください！！");
      }
      else{
        this.isProcessing = true;
        this.axios
        .patch(`http://localhost:3000/api/v1/content/repositories/${this.$route.params.edit_repository_id}`, this.repository)
        .then((res) => {
          this.isProcessing = false;
          alert("変更内容を保存しました。");
        })
        .catch((e) => {
          this.isProcessing = false;
          alert(e);
        });
      }
    },
    moveToChapterView: function (chap_index){
      this.$router.push({ name: 'chapterView', params: { repository_id: this.repository.id, chapter_index: chap_index }});
    },
    moveToChapterEdit: function(chapter_id){
      this.$router.push({ name: 'chapterEdit', params: { repository_id: this.repository.id, edit_chapter_id: chapter_id }});
    },
    deleteChapter: function(chapter_id){
      const result = confirm("このチャプターを削除します。よろしいですか？");
      if (result){
        this.isProcessing = true;
        this.axios
          .delete(`http://localhost:3000/api/v1/content/chapters/${chapter_id}`)
          .then((res) => {
            const newChapters = this.chapters.filter((l) => l.id !== chapter_id)
            this.chapters = newChapters
            this.isProcessing = false;
          })
          .catch((e) => {
            this.isProcessing = false;
            alert(e);
          });
      }
    },
    moveToChapterCreation: function(){
      this.$router.push({ name: 'chapterCreation', params: { repository_id: this.repository.id}});
    }
  },
});
</script>