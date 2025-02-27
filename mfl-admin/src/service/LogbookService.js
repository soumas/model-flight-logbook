import { JsonUtils } from '@/utils/JsonUtils';
import { ApiService } from './ApiService';
export const LogbookService = {
    getPath(year) {
        const path = '/admin/flightsession';
        return year ? path + '/' + year : path;
    },
    async get(year) {
        const data = (await ApiService.get(this.getPath(year))).data;
        JsonUtils.stringsToDates(data);
        return data;
    }
};
