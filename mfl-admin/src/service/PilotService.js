import { ApiService } from './ApiService';
export const PilotService = {
    async getPilots() {
        const data = (await ApiService.get('/admin/pilot/list')).data;
        return data;
    }
};
