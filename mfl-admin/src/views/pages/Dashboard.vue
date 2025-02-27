<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router from '../../router/index';
import { LogbookService } from '../../service/LogbookService';

const model = ref({
    openFlightSessions: 0,
    flightSessionsTotal: 0,
    flightSessionHours: 0,
    specialEvents: 0,
    takeoffs: 0
});
const errorMsg = ref('');
const selctedYear = ref(new Date().getFullYear());

watch(() => router.path, fetchData, { immediate: true });

function fetchData() {
    LogbookService.get(selctedYear.value)
        .then((data) => {
            model.value.openFlightSessions = 0;
            data.forEach((e) => {
                // flightSessionsTotal
                model.value.flightSessionsTotal = model.value.flightSessionsTotal + 1;
                // takeoffs
                if (e.takeoffcount != null) {
                    model.value.takeoffs = model.value.takeoffs + e.takeoffcount;
                }
                // openFlightSessions
                if (e.end == null) {
                    model.value.openFlightSessions = model.value.openFlightSessions + 1;
                }
                // flightSessionHours
                if (e.end != null) {
                    var diff = (e.end - e.start) / 1000;
                    diff /= 60 * 60;
                    model.value.flightSessionHours = model.value.flightSessionHours + diff;
                }
                // specialEvents
                if (e.comment != null && e.comment.length > 1) {
                    model.value.specialEvents = model.value.specialEvents + 1;
                }
            });
            model.value.flightSessionHours = Math.round(model.value.flightSessionHours);
        })
        .catch((e) => handleApiError(e, errorMsg));
}
</script>
<template>
    <div className="card">
        <h1>Dashboard</h1>
    </div>
    <div v-if="errorMsg.length > 0">
        <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
        <br />
    </div>
    <div class="grid grid-cols-12 gap-8">
        <div class="col-span-12 lg:col-span-6 xl:col-span-3">
            <div class="card mb-0">
                <div class="flex justify-between mb-4">
                    <div>
                        <span class="block text-muted-color font-medium mb-4">Aktuell am Flugplatz</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">{{ model.openFlightSessions }} Pilot:innen</div>
                    </div>
                    <div class="flex items-center justify-center bg-blue-100 dark:bg-blue-400/10 rounded-border" style="width: 2.5rem; height: 2.5rem">
                        <i class="pi pi-users text-blue-500 !text-xl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 lg:col-span-6 xl:col-span-3">
            <div class="card mb-0">
                <div class="flex justify-between mb-4">
                    <div>
                        <span class="block text-muted-color font-medium mb-4">Flugbuch {{ selctedYear }}</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">{{ model.takeoffs }} Flüge an {{ model.flightSessionsTotal }} Sessions</div>
                    </div>
                    <div class="flex items-center justify-center bg-orange-100 dark:bg-orange-400/10 rounded-border" style="width: 2.5rem; height: 2.5rem">
                        <i class="pi pi-book text-orange-500 !text-xl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 lg:col-span-6 xl:col-span-3">
            <div class="card mb-0">
                <div class="flex justify-between mb-4">
                    <div>
                        <span class="block text-muted-color font-medium mb-4">Flugzeit {{ selctedYear }}</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">{{ model.flightSessionHours }} Stunden</div>
                    </div>
                    <div class="flex items-center justify-center bg-cyan-100 dark:bg-cyan-400/10 rounded-border" style="width: 2.5rem; height: 2.5rem">
                        <i class="pi pi-clock text-cyan-500 !text-xl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 lg:col-span-6 xl:col-span-3">
            <div class="card mb-0">
                <div class="flex justify-between mb-4">
                    <div>
                        <span class="block text-muted-color font-medium mb-4">Besondere Vorkommnisse {{ selctedYear }}</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">{{ model.specialEvents }} Meldungen</div>
                    </div>
                    <div class="flex items-center justify-center bg-purple-100 dark:bg-purple-400/10 rounded-border" style="width: 2.5rem; height: 2.5rem">
                        <i class="pi pi-comment text-purple-500 !text-xl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 xl:col-span-6">
            <div class="card">
                <div class="flex justify-between items-center mb-6">
                    <div class="font-semibold text-xl">Best Selling Products A</div>
                    <div>
                        <Button icon="pi pi-ellipsis-v" class="p-button-text p-button-plain p-button-rounded" @click="$refs.menu.toggle($event)"></Button>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="flex justify-between items-center mb-6">
                    <div class="font-semibold text-xl">Best Selling Products B</div>
                    <div>
                        <Button icon="pi pi-ellipsis-v" class="p-button-text p-button-plain p-button-rounded" @click="$refs.menu.toggle($event)"></Button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 xl:col-span-6">
            <div class="card">
                <div class="flex justify-between items-center mb-6">
                    <div class="font-semibold text-xl">Best Selling Products C</div>
                    <div>
                        <Button icon="pi pi-ellipsis-v" class="p-button-text p-button-plain p-button-rounded" @click="$refs.menu.toggle($event)"></Button>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="flex justify-between items-center mb-6">
                    <div class="font-semibold text-xl">Best Selling Products D</div>
                    <div>
                        <Button icon="pi pi-ellipsis-v" class="p-button-text p-button-plain p-button-rounded" @click="$refs.menu.toggle($event)"></Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
