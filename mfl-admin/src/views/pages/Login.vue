<script setup>
import { AuthService } from '@/service/AuthService';
import { ref } from 'vue';

const apikey = ref('');
const errorMsg = ref('');

function login() {
    errorMsg.value = '';
    AuthService.login(apikey.value).then((success) => {
        if (!success) errorMsg.value = '<strong>Login fehlgeschlagen</strong>';
    });
}
</script>

<template>
    <div class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden">
        <div class="flex flex-col items-center justify-center">
            <div style="border-radius: 56px; padding: 0.3rem; background: linear-gradient(180deg, var(--primary-color) 10%, rgba(33, 150, 243, 0) 30%)">
                <div class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20" style="border-radius: 53px">
                    <div class="text-center mb-8">
                        <img src="@/assets/images/logo_frameless.svg" alt="MFL Logo" style="margin: auto" /><br />
                        <span class="text-muted-color font-medium">MFL Admin</span>
                    </div>
                    <div>
                        <form @submit.prevent="login">
                            <div v-if="errorMsg.length > 0">
                                <Message severity="error" v-bind:closable="true"><div v-html="errorMsg" /></Message>
                                <br />
                            </div>
                            <IftaLabel variant="in">
                                <Password id="apikey" v-model="apikey" :toggleMask="true" class="mb-4" :feedback="false" required />
                                <label for="apikey">Admin API Key</label>
                            </IftaLabel>
                            <Button label="Login" class="w-full" type="submit"></Button>
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
