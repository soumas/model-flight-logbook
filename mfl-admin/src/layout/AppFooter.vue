<script setup>
import { AppInfoService } from '../service/AppInfoService';

</script>

<template>
    <div class="layout-footer">
        <div>Version: {{ AppInfoService.getVersion() }}</div>
        <div>powered by <a href="https://github.com/soumas/model-flight-logbook" target="_blank" rel="noopener noreferrer" class="text-primary font-bold hover:underline">Model Flight Logbook (GitHub)</a></div>
        <div>
            Theme SAKAI by
            <a href="https://primevue.org" target="_blank" rel="noopener noreferrer" class="text-primary font-bold hover:underline">PrimeVue</a>
        </div>
    </div>
</template>
