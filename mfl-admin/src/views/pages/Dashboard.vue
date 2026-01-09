<script setup>
import { handleApiError } from '@/utils/HttpErrorUtils';
import { ref, watch } from 'vue';
import router from '../../router/index';
import { LogbookService } from '../../service/LogbookService';

const model = ref({});
const errorMsg = ref('');
const selctedYear = ref(new Date().getFullYear());
const yearOptions = ref(Array.from({ length: new Date().getFullYear() - 2024 + 1 }, (_, i) => new Date().getFullYear() - i));

watch(() => router.path, fetchData, { immediate: true });

function fetchData() {
    model.value = {
        sessionsCountJetzt: 0,
        sessionsCountHeute: 0,
        sessionsCount7Tage: 0,

        sessionsCount: 0,
        sessionsUniquePilots: 0,
        sessionDauerMinunten: 0,

        fluegeCount: 0,
        fluegeMaxSession: 0,
        fluegeAvgSession: 0,

        bemerkungenCount: 0,
        automGeschlossenCount: 0,
        sessionsOhneFluegeCount: 0,

        charts: {
            hours: {
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true
                        },
                        title: {
                            display: true,
                            text: 'Auslastung nach Tageszeit (' + selctedYear.value + ')'
                        }
                    },
                    scales: {
                        y: {
                            display: false
                        }
                    }
                },
                data: {
                    labels: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'],
                    datasets: [
                        {
                            label: 'Anzahl Sessions',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        }
                    ]
                }
            },
            months: {
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true
                        },
                        title: {
                            display: true,
                            text: 'Auslastung nach Monaten (' + selctedYear.value + ')'
                        }
                    },
                    scales: {
                        y: {
                            display: false
                        }
                    }
                },
                data: {
                    labels: ['Jan.', 'Febr.', 'März', 'Apr.', 'Mai', 'Juni', 'Juli', 'Aug.', 'Sept.', 'Okt.', 'Nov.', 'Dez.'],
                    datasets: [
                        {
                            label: 'Anzahl Sessions',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        }
                    ]
                }
            }
        }
    };
    LogbookService.get(selctedYear.value)
        .then((data) => {
            model.value.openFlightSessions = 0;
            let pilotSeen = [];
            data.forEach((e) => {
                var today = new Date().setHours(0, 0, 0, 0);

                // sessionsCountJetzt
                if (e.end == null) {
                    model.value.sessionsCountJetzt = model.value.sessionsCountJetzt + 1;
                }
                // sessionsCountHeute
                if (new Date(e.start).setHours(0, 0, 0, 0) == today) {
                    model.value.sessionsCountHeute = model.value.sessionsCountHeute + 1;
                }
                // sessionsCount7Tage
                if (Math.abs((new Date() - e.start) / (1000 * 60 * 60 * 24)) <= 7) {
                    model.value.sessionsCount7Tage = model.value.sessionsCount7Tage + 1;
                }

                // sessionsCount
                model.value.sessionsCount = model.value.sessionsCount + 1;
                // sessionDauerMinunten
                if (e.end != null) {
                    let minutes = (e.end - e.start) / (1000 * 60);
                    if(minutes > 0) {
                        model.value.sessionDauerMinunten = model.value.sessionDauerMinunten + minutes;
                    } else {
                        console.error("Session ID " + e.id + " hat negative Dauer: start=" + e.start + " end=" + e.end);
                    }
                }
                // sessionsUniquePilots
                if (!pilotSeen[e.pilotid]) {
                    pilotSeen[e.pilotid] = {};
                    model.value.sessionsUniquePilots = model.value.sessionsUniquePilots + 1;
                }

                // fluegeCount
                model.value.fluegeCount = model.value.fluegeCount + e.takeoffcount;
                // fluegeMaxSession
                if (e.takeoffcount > model.value.fluegeMaxSession) {
                    model.value.fluegeMaxSession = e.takeoffcount;
                }
                // fluegeAvgSession
                model.value.fluegeAvgSession = model.value.fluegeCount / model.value.sessionsCount;

                // bemerkungenCount
                if (e.comment != null && e.comment.length > 1) {
                    model.value.bemerkungenCount = model.value.bemerkungenCount + 1;
                }
                // automGeschlossenCount
                if (e.endedby == 'sys') {
                    model.value.automGeschlossenCount = model.value.automGeschlossenCount + 1;
                }
                // sessionsOhneFluegeCount
                if (e.takeoffcount <= 0) {
                    model.value.sessionsOhneFluegeCount = model.value.sessionsOhneFluegeCount + 1;
                }

                // chart "hours"
                model.value.charts.hours.data.datasets[0].data[e.start.getHours()]++;
                // chart "months"
                model.value.charts.months.data.datasets[0].data[e.start.getMonth()]++;
            });
        })
        .catch((e) => handleApiError(e, errorMsg));
}
</script>
<template>
    <div className="card">
        <h1 style="float: left">Dashboard</h1>  
        <Select v-model="selctedYear" :options="yearOptions" v-on:change="fetchData" style="float: right" />
        <div style="clear: both"></div>
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
                        <span class="block text-muted-color font-medium mb-4">Aktive Sessions</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">
                            <table class="facttable">
                                <tr>
                                    <td>Jetzt:</td>
                                    <td>{{ model.sessionsCountJetzt }}</td>
                                </tr>
                                <tr>
                                    <td>Heute:</td>
                                    <td>{{ model.sessionsCountHeute }}</td>
                                </tr>
                                <tr>
                                    <td>7 Tage:</td>
                                    <td>{{ model.sessionsCount7Tage }}</td>
                                </tr>
                            </table>
                        </div>
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
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">
                            <table class="facttable">
                                <tr>
                                    <td>Sessions:</td>
                                    <td>{{ model.sessionsCount.toLocaleString() }}</td>
                                </tr>
                                <tr>
                                    <td>Pilot:innen:</td>
                                    <td>{{ model.sessionsUniquePilots.toLocaleString() }}</td>
                                </tr>
                                <tr>
                                    <td>Dauer:</td>
                                    <td>{{ (model.sessionDauerMinunten / 60).toFixed(0) }} Std.</td>
                                </tr>
                            </table>
                        </div>
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
                        <span class="block text-muted-color font-medium mb-4">Flüge {{ selctedYear }}</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">
                            <table class="facttable">
                                <tr>
                                    <td>Anzahl Flüge:</td>
                                    <td>{{ model.fluegeCount.toLocaleString() }}</td>
                                </tr>
                                <tr>
                                    <td>Avg Flüge / Session:</td>
                                    <td>{{ model.fluegeAvgSession.toLocaleString(undefined, { maximumFractionDigits: 2, minimumFractionDigits: 2 }) }}</td>
                                </tr>
                                <tr>
                                    <td>Max. Flüge / Session:</td>
                                    <td>{{ model.fluegeMaxSession.toLocaleString() }}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="flex items-center justify-center bg-cyan-100 dark:bg-cyan-400/10 rounded-border" style="width: 2.5rem; height: 2.5rem">
                        <i class="pi pi-send text-cyan-500 !text-xl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 lg:col-span-6 xl:col-span-3">
            <div class="card mb-0">
                <div class="flex justify-between mb-4">
                    <div>
                        <span class="block text-muted-color font-medium mb-4">Sonstiges {{ selctedYear }}</span>
                        <div class="text-surface-900 dark:text-surface-0 font-medium text-xl">
                            <table class="facttable">
                                <tr>
                                    <td>Vorkommnisse:</td>
                                    <td>{{ model.bemerkungenCount.toLocaleString() }}</td>
                                </tr>
                                <tr>
                                    <td>Sessions ohne Flug:</td>
                                    <td>{{ model.sessionsOhneFluegeCount.toLocaleString() }}</td>
                                </tr>
                                <tr>
                                    <td>Vergessene Sessions:</td>
                                    <td>{{ model.automGeschlossenCount.toLocaleString() }}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="flex items-center justify-center bg-purple-100 dark:bg-purple-400/10 rounded-border" style="width: 2.5rem; height: 2.5rem">
                        <i class="pi pi-flag text-purple-500 !text-xl"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-12 xl:col-span-6">
            <div class="card">
                <Chart type="bar" :data="model.charts.hours.data" :options="model.charts.hours.options" />
            </div>
        </div>
        <div class="col-span-12 xl:col-span-6">
            <div class="card">
                <Chart type="bar" :data="model.charts.months.data" :options="model.charts.months.options" />
            </div>
        </div>
    </div>
</template>
<style>
.facttable td {
    padding-right: 20px;
}
</style>
