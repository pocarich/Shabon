<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-row class="mx-1 mt-5 mb-3">
      <v-btn elevation="2" to="/">←作品一覧に戻る</v-btn>
      <v-spacer></v-spacer>
      <v-btn elevation="2" color="primary" x-large @click="moveToRepositoryEdit();">作品編集</v-btn>
    </v-row>
    <v-row class="text-center">
      <v-col cols=12>
        <h1>{{repository.title}}</h1>
        <h3 v-if="user !== null">作者：{{repository.user_name}}</h3>
        <h3 v-if="originRepository !== null">引用元：<a href="#" @click="moveToOriginRepositoryDetail();">{{originRepository.title}}</a></h3>
        <v-divider class="my-3"></v-divider>
      </v-col>
    </v-row>
    <v-col cols=12>
      <h3>{{repository.detail}}</h3>
    </v-col>
    <v-row class="text-center mt-10">
      <v-col cols=12>
        <h2>チャプター一覧</h2>
        <v-divider class="my-3"></v-divider>
      </v-col>
    </v-row>
    <v-col
      v-for="(chap, index) in chapters" 
      v-bind:key="chap.title"
    >
      <v-card
      max-width="100%"
      elevation="2"
      @click="moveToChapterDetail(index);"
      >
        <v-card-actions>
          <v-list-item class="grow">
            <v-list-item-content>
              <v-list-item-title class="text-h6">{{chap.title}}</v-list-item-title>
            </v-list-item-content>

            <v-row
              align="center"
              justify="end"
            >
              <span class="subheading mr-2">投稿日：{{$dayjs(chap.created_at).format("YYYY/MM/DD")}}</span>
            </v-row>
          </v-list-item>
        </v-card-actions>
      </v-card>
    </v-col>
    <v-col v-if="chapters.length === 0" class="text-center" cols=12>
      <h3>現在チャプターは投稿されていません。</h3>
    </v-col>
    <v-col cols=12>
      <v-divider class="my-1"></v-divider>
      <v-row justify="end" class="mx-1 mt-5">
        <v-btn color="success" class ="mb-5" dark @click="moveToSpinoffCreation();">スピンオフ作成</v-btn>
      </v-row>
    </v-col>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';

export default Vue.extend({
  name: "repositoryDetail",
  data: function () {
    return {
      repository: null,
      originRepository: null,
      chapters: [],
      isProcessing: false,
    };
  },
  components: {
    Loading,
  },
  mounted: async function(){
    this.fetchItems();
  },
  methods: {
    moveToRepositoryEdit: function (){
      this.$router.push({ name: 'repositoryEdit', params: { edit_repository_id: this.$route.params.repository_id }});
    },
    moveToOriginRepositoryDetail: function(){
      this.$router.push({ name: 'repositoryDetail', params: { repository_id: this.originRepository.id }});
    },
    moveToChapterDetail: function (chap_index){
      this.$router.push({ name: 'chapterDetail', params: { repository_id: this.repository.id, chapter_index: chap_index }});
    },
    moveToSpinoffCreation: function(){
      this.$router.push({ name: 'spinoffCreation', params: { origin_repository_id: this.$route.params.repository_id }});
    },
    fetchItems: async function(){
      this.isProcessing = true;
      try{
        //repoInfoとchapInfoの取得を並列処理
        const axiosRepoInfo = this.axios.get(`http://localhost:3000/api/v1/content/repository_with_user/${this.$route.params.repository_id}`);
        const axiosChapInfo = this.axios.get(`http://localhost:3000/api/v1/content/chapters_in_repository/${this.$route.params.repository_id}`);

        const repoInfo = await axiosRepoInfo;
        this.repository = repoInfo.data;

        //引用元が存在するなら引用元作品情報取得
        if(repoInfo.data.origin_id !== null){
          const axiosOriginRepoInfo = await this.axios.get(`http://localhost:3000/api/v1/content/repositories/${this.repository.origin_id}`);
          this.originRepository = axiosOriginRepoInfo.data;
        }else{
          this.originRepository = null;
        }
      
        const chapInfo = await axiosChapInfo;
        this.chapters = chapInfo.data;
      }catch(e){
        alert(e);
      }finally{
        this.isProcessing = false;
      }
    },
  },
  watch: {
    $route: function(to, from){
      this.fetchItems();
    }
  }
});
</script>