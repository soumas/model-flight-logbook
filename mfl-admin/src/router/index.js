import AppLayout from '@/layout/AppLayout.vue';
import { createRouter, createWebHashHistory } from 'vue-router';

export const routes = {
    dashboard: '/dashboard',
    pilots: '/pilots',
    logbook: '/logbook',
    messages: '/messages',
    login: '/login',
    logout: '/logout'
};

const router = createRouter({
    history: createWebHashHistory(),
    routes: [
        {
            path: '/',
            component: AppLayout,
            children: [
                {
                    path: '/',
                    redirect: routes.dashboard
                },
                {
                    path: '/mfl-admin',
                    redirect: routes.dashboard
                },
                {
                    path: routes.dashboard,
                    component: () => import('@/views/Dashboard.vue')
                },
                {
                    path: routes.pilots,
                    component: () => import('@/views/pages/Pilots.vue')
                },
                {
                    path: routes.pilots + '/:id',
                    component: () => import('@/views/pages/PilotDetail.vue')
                },
                {
                    path: routes.logbook,
                    component: () => import('@/views/pages/Logbook.vue')
                },
                {
                    path: routes.messages,
                    component: () => import('@/views/pages/Messages.vue')
                }
            ]
        },
        {
            path: routes.login,
            component: () => import('@/views/pages/Login.vue')
        },
        {
            path: routes.logout,
            component: () => import('@/views/pages/Logout.vue')
        }
    ]
});

export default router;
