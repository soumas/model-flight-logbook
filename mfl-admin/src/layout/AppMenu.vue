<script setup>
import { ref } from 'vue';

import AppMenuItem from './AppMenuItem.vue';

const model = ref([
    {
        items: [
            { label: 'Dashboard', icon: 'pi pi-fw pi-home', to: '/' },
            { label: 'Piloten', icon: 'pi pi-fw pi-users', to: '/pilots' },
            { label: 'Flugbuch', icon: 'pi pi-fw pi-book', to: '/logbook' },
            { label: 'Nachrichten', icon: 'pi pi-fw pi-bell', to: '/messages' }
        ]
    },
    {
        items: [{ label: 'Logout', icon: 'pi pi-fw pi-sign-out', to: '/login' }]
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
