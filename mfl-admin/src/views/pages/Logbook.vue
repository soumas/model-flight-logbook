<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router from '../../router/index';
import { LogbookService } from '../../service/LogbookService';

const model = ref([]);
const errorMsg = ref('');
const filters = ref({ global: {} });
const table = ref(null);
const selctedYear = ref(new Date().getFullYear());
const yearOptions = ref(Array.from({ length: new Date().getFullYear() - 2024 + 1 }, (_, i) => new Date().getFullYear() - i));
const exportFilename = ref('MFL Flugbuch');

watch(() => router.path, fetchData, { immediate: true });

function fetchData() {
    model.value = [];
    updateExportFilename();
    LogbookService.get(selctedYear.value)
        .then((data) => {
            data.forEach((e) => {
                e.startDate = e.start;
            });
            model.value = data;
        })
        .catch((e) => handleApiError(e, errorMsg));
}

function updateExportFilename() {
    exportFilename.value = `MFL Flugbuch ${selctedYear.value}`;
    if (filters.value['global'].value != null && filters.value['global'].value.length > 0) {
        exportFilename.value = `${exportFilename.value} ${filters.value['global'].value}`;
    }
}

function exportCSV() {
    table.value.exportCSV();
}

function rowClick() {
    //router.push(routes.logbook + '/' + e.data.id);
}

function exportValue(obj) {
    if (obj.field === 'startDate' && obj.data instanceof Date) {
        return obj.data.toLocaleDateString([], { day: '2-digit', month: '2-digit', year: 'numeric' });
    } else if ((obj.field === 'start' || obj.field === 'end') && obj.data instanceof Date) {
        return obj.data.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    } else if (obj.data === true) {
        return 'Ja';
    } else if (obj.data === false) {
        return 'Nein';
    }
    return obj.data;
}
</script>
<template>
    <div className="card">
        <h1 style="float: left">Flugbuch</h1>
        <Button @click="fetchData" icon="pi pi-refresh" severity="secondary" style="float: right"></Button>
        <div style="clear: both"></div>
    </div>
    <div className="card">
        <div v-if="errorMsg.length > 0">
            <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
            <br />
        </div>
        <div class="flex justify-end">
            <Select v-model="selctedYear" :options="yearOptions" v-on:change="fetchData" />
            <IconField>
                <InputIcon>
                    <i class="pi pi-search" />
                </InputIcon>
                <InputText v-model="filters['global'].value" placeholder="Volltextfilter" v-on:input="updateExportFilename" />
            </IconField>
            <Button label="Exportieren" @click="exportCSV" />
        </div>
        <br />
        <DataTable
            ref="table"
            :value="model"
            tableStyle="min-width: 50rem"
            sortField="start"
            :sortOrder="-1"
            selectionMode="multiple"
            @row-click="rowClick($event)"
            paginator
            :rows="20"
            v-model:filters="filters"
            :globalFilterFields="['airport', 'pilotname', 'comment', 'start']"
            :exportFunction="exportValue"
            :export-filename="exportFilename"
        >
            <template #empty><Message>Für den ausgewählten Zeitraum wurde kein Logbucheintrag gefunden</Message></template>
            <template #paginatorcontainer="{ first, last, page, pageCount, prevPageCallback, nextPageCallback, totalRecords, firstPageCallback, lastPageCallback }">
                <div class="flex items-center gap-4 py-1 px-2 justify-between">
                    <Button icon="pi pi-angle-double-left" rounded text @click="firstPageCallback" :disabled="page === 0" />
                    <Button icon="pi pi-angle-left" rounded text @click="prevPageCallback" :disabled="page === 0" />
                    <div class="text-color font-medium">
                        <span class="hidden sm:block">Zeilen {{ first }}-{{ last }} von {{ totalRecords }}</span>
                        <span class="block sm:hidden">Seite {{ page + 1 }} von {{ pageCount }}</span>
                    </div>
                    <Button icon="pi pi-angle-right" rounded text @click="nextPageCallback" :disabled="page === pageCount - 1" />
                    <Button icon="pi pi-angle-double-right" rounded text @click="lastPageCallback" :disabled="page === pageCount - 1" />
                </div>
            </template>
            <Column field="startDate" header="Datum" sortable>
                <template #body="{ data }">
                    <span>{{ data.startDate.toLocaleDateString([], { day: '2-digit', month: '2-digit', year: 'numeric' }) }}</span>
                </template>
            </Column>
            <Column field="airport" header="Flugplatz" sortable></Column>
            <Column field="pilotname" header="Pilot" sortable></Column>
            <Column field="start" header="Beginn" sortable>
                <template #body="{ data }">
                    {{ data.start.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) }}
                </template>
            </Column>
            <Column field="end" header="Ende" sortable>
                <template #body="{ data }">
                    <span v-if="data.end">{{ data.end.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) }}</span>
                </template>
            </Column>
            <Column field="takeoffcount" header="Flüge" sortable></Column>
            <Column field="maxAltitude" header="Max. Flughöhe" sortable></Column>
            <Column field="airspaceObserver" header="Luftraum-Beobachter" sortable>
                <template #body="{ data }">
                    <Checkbox v-model="data.airspaceObserver" binary readonly="readonly"></Checkbox>
                </template>
            </Column>
            <Column field="comment" header="Besonderheiten, Vorkommnisse" sortable></Column>
        </DataTable>
    </div>
</template>
