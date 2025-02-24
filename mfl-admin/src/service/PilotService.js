import { JsonUtils } from '@/utils/JsonUtils';
import { ApiService } from './ApiService';
export const PilotService = {
    getPath(id) {
        const path = '/admin/pilot';
        return id ? path + '/' + id : path;
    },
    async getPilots() {
        const data = (await ApiService.get(this.getPath())).data;
        JsonUtils.stringsToDates(data);
        return data;
    },
    async create(pilot) {
        try {
            JsonUtils.datesToStrings(pilot);
            const data = (await ApiService.post(this.getPath(), pilot)).data;
            JsonUtils.stringsToDates(data);
            return data;
        } catch (e) {
            JsonUtils.stringsToDates(pilot);
            throw e;
        }
    },
    async get(id) {
        const data = (await ApiService.get(this.getPath(id))).data;
        JsonUtils.stringsToDates(data);
        return data;
    },
    async update(id, pilot) {
        try {
            JsonUtils.datesToStrings(pilot);
            const data = (await ApiService.put(this.getPath(id), pilot)).data;
            JsonUtils.stringsToDates(data);
            return data;
        } catch (e) {
            JsonUtils.stringsToDates(pilot);
            throw e;
        }
    },
    async delete(id) {
        return ApiService.delete(this.getPath(id));
    }
};
