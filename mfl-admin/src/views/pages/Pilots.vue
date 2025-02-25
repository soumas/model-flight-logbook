<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router, { routes } from '../../router/index';
import { PilotService } from '../../service/PilotService';
import.meta.env;

const model = ref([]);
const menu = Array({ label: 'Pilot:in hinzufügen', icon: 'pi pi-fw pi-user-plus', command: () => router.push(routes.pilots + '/create') });
const errorMsg = ref('');

watch(() => router.path, fetchData, { immediate: true });

function fetchData() {
    PilotService.getPilots()
        .then((data) => (model.value = data))
        .catch((e) => handleApiError(e, errorMsg));
}

function rowClick(e) {
    router.push(routes.pilots + '/' + e.data.id);
}
</script>
<template>
    <div className="card">
        <h1>Pilot:innen</h1>
        <Menubar :model="menu" />
        <div v-if="errorMsg.length > 0">
            <br />
            <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
        </div>
        <br />
        <DataTable :value="model" selec tableStyle="min-width: 50rem" sortField="lastname" :sortOrder="1" selectionMode="single" @row-click="rowClick($event)">
            <Column field="lastname" header="Name">
                <template #body="{ data }">{{ data.lastname }} {{ data.firstname }}</template>
            </Column>
            <Column field="id" header="ID"></Column>
            <Column field="email" header="E-Mail"></Column>
            <Column field="active" header="Aktiv">
                <template #body="{ data }">
                    <Checkbox v-model="data.active" binary readonly="readonly"></Checkbox>
                </template>
            </Column>
        </DataTable>
    </div>
</template>
