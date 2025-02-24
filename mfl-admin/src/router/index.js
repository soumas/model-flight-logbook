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
                    component: () => import('@/views/Dashboard.vue')
                },
                {
                    path: '/pilots',
                    component: () => import('@/views/pages/Pilots.vue')
                },
                {
                    path: '/pilots/:id',
                    component: () => import('@/views/pages/PilotDetail.vue')
                },
                {
                    path: '/logbook',
                    component: () => import('@/views/pages/Logbook.vue')
                },
                {
                    path: '/messages',
                    component: () => import('@/views/pages/Messages.vue')
                }
            ]
        },
        {
            path: '/login',
            component: () => import('@/views/pages/Login.vue')
        },
        {
            path: '/logout',
            component: () => import('@/views/pages/Logout.vue')
        }
    ]
});

export default router;
