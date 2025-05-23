import { JsonUtils } from '@/utils/JsonUtils';
import { ApiService } from './ApiService';
export const PilotService = {
    getPath(id) {
        const path = '/admin/pilot';
        return id ? path + '/' + id : path;
    },
    async get(id) {
        const data = (await ApiService.get(this.getPath(id))).data;
        JsonUtils.stringsToDates(data);
        return data;
    },
    async create(entity) {
        try {
            JsonUtils.datesToStrings(entity);
            const data = (await ApiService.post(this.getPath(), entity)).data;
            JsonUtils.stringsToDates(data);
            return data;
        } catch (e) {
            JsonUtils.stringsToDates(entity);
            throw e;
        }
    },
    async update(id, entity) {
        try {
            JsonUtils.datesToStrings(entity);
            const data = (await ApiService.put(this.getPath(id), entity)).data;
            JsonUtils.stringsToDates(data);
            return data;
        } catch (e) {
            JsonUtils.stringsToDates(entity);
            throw e;
        }
    },
    async delete(id) {
        return ApiService.delete(this.getPath(id));
    }
};
