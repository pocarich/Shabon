import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            name: 'home',
            component: () => import('../components/pages/Home.vue')
        },
        {
            path: '/shabon_description',
            name: 'shabonDescription',
            component: () => import('../components/pages/ShabonDescription.vue')
        },
        {
            path: '/terms_of_service',
            name: 'termsOfService',
            component: () => import('../components/pages/TermsOfService.vue')
        },
        {
            path: '/repository_creation',
            name: 'repositoryCreation',
            component: () => import('../components/pages/RepositoryCreation.vue')
        },
        {
            path: '/repository_detail/:repository_id',
            name: 'repositoryDetail',
            component: () => import('../components/pages/RepositoryDetail.vue')
        },
        {
            path: '/repository_edit/:edit_repository_id',
            name: 'repositoryEdit',
            component: () => import('../components/pages/RepositoryEdit.vue')
        },
        {
            path: '/chapter_detail/:repository_id/:chapter_index',
            name: 'chapterDetail',
            component: () => import('../components/pages/ChapterDetail.vue')
        },
        {
            path: '/chapter_creation/:repository_id',
            name: 'chapterCreation',
            component: () => import('../components/pages/ChapterCreation.vue')
        },
        {
            path: '/chapter_view/:repository_id/:chapter_index',
            name: 'chapterView',
            component: () => import('../components/pages/ChapterView.vue')
        },
        {
            path: '/chapter_edit/:repository_id/:edit_chapter_id',
            name: 'chapterEdit',
            component: () => import('../components/pages/ChapterEdit.vue')
        },
        {
            path: '/spinoff_creation/:origin_repository_id',
            name: 'spinoffCreation',
            component: () => import('../components/pages/SpinoffCreation.vue')
        },
        {
            path: '/mypage',
            name: 'myPage',
            component: () => import('../components/pages/MyPage.vue')
        },
        {
            path: '/fishers_debug',
            name: 'developer-debug',
            component: () => import('../components/pages/Debug.vue')
        }
    ],
    scrollBehavior (to, from, savedPosition) {
        if (savedPosition) {
            return savedPosition;
        } else {
            return { x: 0, y: 0 };
        }
    }
})