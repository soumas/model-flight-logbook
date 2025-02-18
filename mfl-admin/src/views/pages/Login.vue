<script setup>
import axios from 'axios';
import { ref } from 'vue';

const endpoint = ref('http://localhost:8082');
const apikey = ref('');
async function login() {
    //localStorage.setItem('host', host);
    //localStorage.setItem('apikey', apikey);
    var result = await axios.get(endpoint.value + '/admin/pilot/list', { headers: { accept: 'application/json', 'x-api-key': apikey.value } });
    console.debug(result);
}
</script>

<template>
    <div class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden">
        <div class="flex flex-col items-center justify-center">
            <div style="border-radius: 56px; padding: 0.3rem; background: linear-gradient(180deg, var(--primary-color) 10%, rgba(33, 150, 243, 0) 30%)">
                <div class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20" style="border-radius: 53px">
                    <div class="text-center mb-8">
                        <img src="@/assets/images/logo_frameless.svg" alt="MFL Logo" style="margin: auto" /><br />
                        <span class="text-muted-color font-medium">&nbsp;</span>
                    </div>
                    <div>
                        <InputText id="endpoint" type="text" placeholder="Endpoint" class="w-full md:w-[30rem] mb-8" v-model="endpoint" />
                        <Password id="apikey" v-model="apikey" placeholder="Admin API Key" :toggleMask="true" class="mb-4" fluid :feedback="false"></Password><br />
                        <Button label="Login" class="w-full" @click="login"></Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.pi-eye {
    transform: scale(1.6);
    margin-right: 1rem;
}

.pi-eye-slash {
    transform: scale(1.6);
    margin-right: 1rem;
}
</style>
