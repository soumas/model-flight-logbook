<script setup>
import { ref } from 'vue';

import { routes } from '@/router';
import AppMenuItem from './AppMenuItem.vue';

const model = ref([
    {
        items: [
            { label: 'Dashboard', icon: 'pi pi-fw pi-home', to: routes.dashboard },
            { label: 'Pilot:innen', icon: 'pi pi-fw pi-users', to: routes.pilots },
            { label: 'Flugbuch', icon: 'pi pi-fw pi-book', to: routes.logbook },
            { label: 'Nachrichten', icon: 'pi pi-fw pi-bell', to: routes.messages }
        ]
    },
    {
        items: [{ label: 'Logout', icon: 'pi pi-fw pi-sign-out', to: routes.logout }]
    }
]);
</script>

<template>
    <ul class="layout-menu">
        <template v-for="(item, i) in model" :key="item">
            <app-menu-item v-if="!item.separator" :item="item" :index="i"></app-menu-item>
            <li v-if="item.separator" class="menu-separator"></li>
        </template>
    </ul>
</template>

<style lang="scss" scoped>
.logocontainer {
    border-top: solid var(--surface-border) 1px;
    border-bottom: solid var(--surface-border) 1px;
    text-align: center;
    margin: 20px 0px;
    padding: 10px 0px;
}
</style>
