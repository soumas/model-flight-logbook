<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router, { routes } from '../../router/index';
import { PilotService } from '../../service/PilotService';

const model = ref([]);
const errorMsg = ref('');
const filters = ref({ global: {} });

watch(() => router.path, fetchData, { immediate: true });

function fetchData() {
    PilotService.get()
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
        <div v-if="errorMsg.length > 0">
            <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
            <br />
        </div>
        <div class="flex justify-between">
            <Button label="Pilot:in hinzufügen" @click="() => router.push(routes.pilots + '/create')" icon="pi pi-fw pi-user-plus" severity="secondary"></Button>
            <IconField>
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText v-model="filters['global'].value" placeholder="Volltextfilter" />
            </IconField>
        </div>
        <br />
        <DataTable :value="model" sortField="lastname" :sortOrder="1" selectionMode="multiple" @row-click="rowClick($event)" paginator :rows="20" v-model:filters="filters" :globalFilterFields="['email', 'lastname', 'firstname', 'id']">
            <template #empty><Message>Es wurde noch kein:e Pilot:in erstellt</Message></template>
            <template #paginatorcontainer="{ first, last, page, pageCount, prevPageCallback, nextPageCallback, totalRecords }">
                <div class="flex items-center gap-4 py-1 px-2 justify-between">
                    <Button icon="pi pi-chevron-left" rounded text @click="prevPageCallback" :disabled="page === 0" />
                    <div class="text-color font-medium">
                        <span class="hidden sm:block">Zeilen {{ first }}-{{ last }} von {{ totalRecords }}</span>
                        <span class="block sm:hidden">Seite {{ page + 1 }} von {{ pageCount }}</span>
                    </div>
                    <Button icon="pi pi-chevron-right" rounded text @click="nextPageCallback" :disabled="page === pageCount - 1" />
                </div>
            </template>
            <Column field="lastname" header="Name" sortable>
                <template #body="{ data }">{{ data.lastname }} {{ data.firstname }}</template>
            </Column>
            <Column field="id" header="ID" sortable></Column>
            <Column field="email" header="E-Mail" sortable></Column>
            <Column field="active" header="Aktiv" sortable>
                <template #body="{ data }">
                    <Checkbox v-model="data.active" binary readonly="readonly"></Checkbox>
                </template>
            </Column>
        </DataTable>
    </div>
</template>
