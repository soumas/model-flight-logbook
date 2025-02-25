<script setup>
import router, { routes } from '@/router';
import { handleApiError } from '@/utils/HttpErrorUtils';
import { useConfirm } from 'primevue/useconfirm';
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import { PilotService } from '../../service/PilotService';

const confirm = useConfirm();
const route = useRoute();
const successMsg = ref('');
const errorMsg = ref('');
const model = ref({});

const isCreate = ref(route.params.id == 'create');
const menu = Array({ label: 'Zur Liste', icon: 'pi pi-fw pi-arrow-left', command: () => router.push(routes.pilots) }, { label: 'Löschen', icon: 'pi pi-fw pi-trash', command: deleteIem, visible: !isCreate.value });

function deleteIem() {
    confirm.require({
        message: 'Pilot:in und alle zugehörigen Flugbucheinträge löschen?',
        header: 'Achtung!',
        icon: 'pi pi-info-circle p-confirmdialog-icon',
        acceptProps: {
            label: 'Ja, alles löschen',
            severity: 'danger'
        },
        rejectProps: {
            label: 'Nein'
        },
        accept: () =>
            PilotService.delete(route.params.id)
                .then(() => router.push(routes.pilots))
                .catch((e) => handleApiError(e, errorMsg))
    });
}

async function onFormSubmit() {
    resetMsgs();
    if (isCreate.value) {
        console.warn(model.value);
        PilotService.create(model.value)
            .then((persisted) => {
                successMsg.value = 'Pilot:in wurde hinzugefügt';
                model.value = persisted;
                router.push(routes.pilots + '/' + model.value.id);
                isCreate.value = false;
            })
            .catch((e) => handleApiError(e, errorMsg));
    } else {
        PilotService.update(route.params.id, model.value)
            .then((persisted) => {
                successMsg.value = 'Pilot:in wurde gespeichert';
                model.value = persisted;
                router.push(routes.pilots + '/' + model.value.id);
            })
            .catch((e) => handleApiError(e, errorMsg));
    }
}

function resetMsgs() {
    errorMsg.value = '';
    successMsg.value = '';
}

onMounted(() => {
    if (isCreate.value) {
        model.value = { active: true, acIsUtmOperator: false };
    } else {
        PilotService.get(route.params.id)
            .then((data) => (model.value = data))
            .catch((e) => handleApiError(e, errorMsg));
    }
});
</script>
<template>
    <form @submit.prevent="onFormSubmit">
        <div class="card">
            <h1 v-if="isCreate">Pilot:in hinzufügen</h1>
            <h1 v-else>Pilot:in bearbeiten</h1>
            <Menubar :model="menu" />
            <div v-if="successMsg.length > 0">
                <br />
                <Message severity="success" v-bind:closable="true"><div v-html="successMsg" /></Message>
            </div>
            <div v-if="errorMsg.length > 0">
                <br />
                <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
            </div>
            <Fieldset legend="Stammdaten">
                <div class="flex flex-col gap-4">
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <InputText id="id" type="text" v-model="model.id" required />
                                <label for="id">ID</label>
                            </IftaLabel>
                        </div>
                    </div>
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <InputText id="firstname" type="text" v-model="model.firstname" required />
                                <label for="firstname">Vorname</label>
                            </IftaLabel>
                        </div>
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <InputText id="lastname" type="text" v-model="model.lastname" required />
                                <label for="lastname">Nachname</label>
                            </IftaLabel>
                        </div>
                    </div>
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <InputText id="phonenumber" type="tel" v-model="model.phonenumber" required />
                                <label for="phonenumber">Telefonnummer</label>
                            </IftaLabel>
                        </div>
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <InputText id="email" type="email" v-model="model.email" required />
                                <label for="email">E-Mail</label>
                            </IftaLabel>
                        </div>
                    </div>
                </div>
            </Fieldset>
            <Fieldset legend="Austro Control">
                <div class="flex flex-col gap-4">
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <DatePicker id="acRegistrationValidTo" v-model="model.acRegistrationValidTo" dateFormat="dd.mm.yy" />
                                <label for="acRegistrationValidTo">Registrierung gültig bis</label>
                            </IftaLabel>
                        </div>
                        <div class="flex flex-wrap gap-2">
                            <IftaLabel variant="in">
                                <DatePicker id="acPilotlicenseValidTo" v-model="model.acPilotlicenseValidTo" dateFormat="dd.mm.yy" />
                                <label for="acPilotlicenseValidTo">Drohnenführerschein gültig bis</label>
                            </IftaLabel>
                        </div>
                    </div>
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-col md:flex-row gap-4">
                            <div class="flex flex-wrap gap-2">
                                <ToggleSwitch inputId="acIsUtmOperator" v-model="model.acIsUtmOperator" binary />
                                <label for="acIsUtmOperator">UTM Interaktionen mit diesem User erlauben</label>
                            </div>
                        </div>
                    </div>
                </div>
            </Fieldset>
            <Fieldset legend="Status">
                <div class="flex flex-col gap-4">
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-wrap gap-2">
                            <ToggleSwitch v-model="model.active" inputId="activex" binary />
                            <label for="activex">Aktiv</label>
                        </div>
                    </div>
                </div>
            </Fieldset>
            <br />
            <div class="flex flex-col md:flex-row gap-4">
                <div class="flex flex-wrap gap-2">
                    <Button label="Speichern" class="w-full" type="submit"></Button>
                </div>
            </div>
        </div>
    </form>
</template>
