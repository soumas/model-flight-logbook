<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router, { routes } from '../../router/index';
import { PilotService } from '../../service/PilotService';

const model = ref([]);
const menu = Array({ label: 'Pilot:in hinzufügen', icon: 'pi pi-fw pi-user-plus', command: () => router.push(routes.pilots + '/create') });
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
        <Menubar :model="menu" />
        <div v-if="errorMsg.length > 0">
            <br />
            <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
        </div>
        <br />
        <DataTable
            :value="model"
            sortField="lastname"
            :sortOrder="1"
            selectionMode="multiple"
            @row-click="rowClick($event)"
            paginator
            :rows="20"
            :rowsPerPageOptions="[20, 50, 100, 200, 500]"
            v-model:filters="filters"
            :globalFilterFields="['email', 'lastname', 'firstname', 'id']"
        >
            <template #empty> Es gibt noch keine:n Pilot:in</template>
            <template #header>
                <div class="flex justify-end">
                    <IconField>
                        <InputIcon>
                            <i class="pi pi-search" />
                        </InputIcon>
                        <InputText v-model="filters['global'].value" placeholder="Filter" />
                    </IconField>
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
