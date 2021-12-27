<template>
  <v-container>
    <loading :active.sync="isProcessing" ></loading>

    <v-btn elevation="2" class="mx-1 mt-5 mb-3" @click="moveToDetail();">←作品ページに戻る</v-btn>
    <v-col cols=12>
      <h1 class="text-center">スピンオフ作成</h1>
      <h3 class="text-center">引用元：{{originRepository.title}}</h3>      
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
  name: "spinoffCreation",
  data: function () {
    return {
      originRepository: null,
      title: "",
      description: "",
      detail: "",
      isProcessing: false,
    };
  },
  components: {
    Loading,
  },
  mounted: async function(){
    this.isProcessing = true;
    try{
      const axiosOriginRepoInfo = await this.axios.get(`http://localhost:3000/api/v1/content/repositories/${this.$route.params.origin_repository_id}`);
      this.originRepository = axiosOriginRepoInfo.data;
      this.title = this.originRepository.title;
      this.title = this.title.substring(0, Math.min(this.title.length, 22)) + ' - スピンオフ';
      this.description = this.originRepository.description;
      this.detail = this.originRepository.detail;
    }catch(e){
      alert(e);
    }finally{
      this.isProcessing = false;
    }
  },
  methods: {
    moveToDetail: function (){
      this.$router.push({ name: 'repositoryDetail', params: { repository_id: this.$route.params.origin_repository_id }});
    },
    upload: async function () {
      if (!this.title){
        alert("作品名を入力してください！！");
      }
      else{
        this.isProcessing = true;
        try{
          //スピンオフ作品ページ作成と引用元作品のチャプターリストの取得を並列処理
          const axiosRepoInfo = this.axios.post("http://localhost:3000/api/v1/content/repositories", {
            title: this.title,
            description: this.description,
            detail: this.detail,
            origin_id: this.$route.params.origin_repository_id,
            user_id: 1,
          });
          const axiosChapsInfo = this.axios.get(`http://localhost:3000/api/v1/content/chapters_detail_in_repository/${this.$route.params.origin_repository_id}`);
          
          const chapsInfo = await axiosChapsInfo;
          const newRepoInfo = await axiosRepoInfo;
          const chapters = chapsInfo.data;
          const newRepository = newRepoInfo.data;

          //引用元作品のチャプターリストをスピンオフ作品ページにコピー
          Promise.all(chapters.map(async chap => {
            return await this.axios
              .post("http://localhost:3000/api/v1/content/chapters", {
                title: chap.title,
                text: chap.text,
                repository_id: newRepository.id
              });
          }));

          alert("スピンオフを作成しました！");
          this.$router.push({ name: 'repositoryDetail', params: { repository_id: newRepository.id }});
        }catch(e){
          alert(e);
        }finally{
          this.isProcessing = false;
        }
      }
    },
  },
});
</script>