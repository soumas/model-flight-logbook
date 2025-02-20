import AppLayout from '@/layout/AppLayout.vue';
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',
            component: AppLayout,
            children: [
                {
                    path: '/',
                    redirect: '/dashboard'
                },
                {
                    path: '/dashboard',
                    name: 'dashboard',
                    component: () => import('@/views/Dashboard.vue')
                },
                {
                    path: '/pilots',
                    name: 'pilots',
                    component: () => import('@/views/pages/Pilots.vue')
                },
                {
                    path: '/logbook',
                    name: 'logbook',
                    component: () => import('@/views/pages/Logbook.vue')
                },
                {
                    path: '/messages',
                    name: 'messages',
                    component: () => import('@/views/pages/Messages.vue')
                }
            ]
        },
        {
            path: '/login',
            name: 'login',
            component: () => import('@/views/pages/Login.vue')
        },
        {
            path: '/logout',
            name: 'logout',
            component: () => import('@/views/pages/Logout.vue')
        }
    ]
});

export default router;
