<script setup>
import { AuthService } from '@/service/AuthService';
import { useToast } from 'primevue/usetoast';
import { ref } from 'vue';
const toast = useToast();

const endpoint = ref('http://localhost:8082');
const apikey = ref('');

async function login() {
    if ((await AuthService.login(endpoint.value, apikey.value)) == false) {
        toast.add({ severity: 'error', summary: 'Login fehlgeschlagen', detail: 'Bitte überprüfen Sie Ihre Eingabe', life: 3000 });
    }
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
                        <form @submit.prevent="printToConsole">
                            <InputText id="endpoint" v-model="endpoint" type="text" placeholder="Endpoint" class="w-full md:w-[30rem] mb-8" />
                            <Password id="apikey" v-model="apikey" placeholder="Admin API Key" :toggleMask="true" class="mb-4" fluid :feedback="false"></Password>
                            <Button label="Login" class="w-full" @click="login" type="submit"></Button>
                        </form>
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
