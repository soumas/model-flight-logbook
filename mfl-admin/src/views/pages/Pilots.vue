<script setup>
import { ref, watch } from 'vue';
import router from '../../router/index';
import { PilotService } from '../../service/PilotService';

watch(() => router.path, fetchData, { immediate: true });

async function fetchData() {
    const data = await PilotService.getPilots();
    model.value.list = data;
}

function onFormSubmit() {
    model.value.selectedPilot = null;
}

const model = ref({
    list: [],
    selectedPilot: null
});
</script>
<template>
    <div v-if="model.selectedPilot == null" className="card">
        <h1>Pilot:innen</h1>
        <DataTable :value="model.list" v-model:selection="model.selectedPilot" tableStyle="min-width: 50rem" sortField="lastname" :sortOrder="1" selectionMode="single">
            <Column field="lastname" sortable header="Name">
                <template #body="{ data }">{{ data.lastname }} {{ data.firstname }}</template>
            </Column>
            <Column field="id" header="ID" sortable></Column>
            <Column field="email" sortable header="E-Mail"></Column>
            <Column field="active" sortable header="Aktiv">
                <template #body="{ data }">
                    <Checkbox v-model="data.active" binary readonly="readonly"></Checkbox>
                </template>
            </Column>
        </DataTable>
    </div>
    <div v-else className="card">
        <h1>{{ model.selectedPilot.lastname }} {{ model.selectedPilot.firstname }}</h1>
        <form @submit="onFormSubmit">
            <FloatLabel>
                <InputText id="lastname" type="text" v-model="model.selectedPilot.lastname" />
                <label for="lastname">Vorname</label>
            </FloatLabel>
            <FloatLabel>
                <InputText id="firstname" type="text" v-model="model.selectedPilot.firstname" />
                <label for="firstname">Vorname</label>
            </FloatLabel>
            <Button label="Speichern" class="w-full" type="submit"></Button>
        </form>
    </div>
</template>
