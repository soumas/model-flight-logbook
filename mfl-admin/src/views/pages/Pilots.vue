<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router, { routes } from '../../router/index';
import { PilotService } from '../../service/PilotService';

const model = ref([]);
const errorMsg = ref('');
const filters = ref({ global: {} });
const table = ref(null);

watch(() => router.path, fetchData, { immediate: true });

function fetchData() {
    model.value = [];
    PilotService.get()
        .then((data) => (model.value = data))
        .catch((e) => handleApiError(e, errorMsg));
}

function rowClick(e) {
    router.push(routes.pilots + '/' + e.data.id);
}

function evalAcDateSeverity(date, validate) {
    let now = new Date();
    now.setHours(0, 0, 0, 0);
    if (validate && (date == null || now > date)) {
        return 'danger';
    } else if (validate && (Math.abs((now - date) / (1000 * 60 * 60 * 24)) <= 30)) {
        return 'warn';
    }
    return 'secondary';
}

function exportCSV() {
    table.value.exportCSV();
}

function exportValue(obj) {
    if (obj.data instanceof Date) {
        return obj.data.toLocaleDateString([], { day: '2-digit', month: '2-digit', year: 'numeric' });
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
        <h1 style="float: left">Pilot:innen</h1>
        <Button @click="fetchData" icon="pi pi-refresh" severity="secondary" style="float: right"></Button>
        <div style="clear: both"></div>
    </div>
    <div className="card">
        <div v-if="errorMsg.length > 0">
            <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
            <br />
        </div>
        <div class="flex justify-between">
            <Button label="Pilot:in hinzufügen" @click="() => router.push(routes.pilots + '/create')" icon="pi pi-fw pi-user-plus"></Button>
            <div class="flex justify-end">
                <IconField>
                    <InputIcon>
                        <i class="pi pi-search" />
                    </InputIcon>
                    <InputText v-model="filters['global'].value" placeholder="Volltextfilter" />
                </IconField>
                <Button label="Exportieren" @click="exportCSV" severity="secondary" />
            </div>
        </div>
        <br />
        <DataTable
            ref="table"
            :value="model"
            sortField="lastname"
            :sortOrder="1"
            selectionMode="multiple"
            @row-click="rowClick($event)"
            paginator
            :rows="20"
            v-model:filters="filters"
            :globalFilterFields="['email', 'lastname', 'firstname', 'id', 'phonenumber']"
            :exportFunction="exportValue"
            export-filename="MFL PilotInnen"
        >
            <template #empty><Message>Es wurde kein:e Pilot:in gefunden</Message></template>
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
            <Column field="id" header="ID" sortable></Column>
            <Column field="lastname" header="Nachname" sortable></Column>
            <Column field="firstname" header="Vorname" sortable></Column>
            <Column field="phonenumber" header="Telefon" sortable></Column>
            <Column field="email" header="E-Mail" sortable></Column>
            <Column field="acRegistrationValidTo" header="Registrierung" sortable>
                <template #body="{ data }">
                    <Badge v-if="data.acRegistrationValidTo != null" :severity="evalAcDateSeverity(data.acRegistrationValidTo, data.validateAcRegistration)" :value="data.acRegistrationValidTo.toLocaleDateString([], { day: '2-digit', month: '2-digit', year: 'numeric' })" />
                    <Badge v-if="data.acRegistrationValidTo == null && data.validateAcRegistration" severity="danger">Datum fehlt</Badge>
                </template>
            </Column>
            <Column field="acPilotlicenseValidTo" header="Führerschein" sortable>
                <template #body="{ data }">
                    <Badge v-if="data.acPilotlicenseValidTo != null" :severity="evalAcDateSeverity(data.acPilotlicenseValidTo, data.validateAcPilotlicense)" :value="data.acPilotlicenseValidTo.toLocaleDateString([], { day: '2-digit', month: '2-digit', year: 'numeric' })" />
                    <Badge v-if="data.acPilotlicenseValidTo == null && data.validateAcPilotlicense" severity="danger">Datum fehlt</Badge>
                </template>
            </Column>
            <Column field="active" header="Aktiv" sortable>
                <template #body="{ data }">
                    <Checkbox v-model="data.active" binary readonly="readonly"></Checkbox>
                </template>
            </Column>
        </DataTable>
    </div>
</template>
