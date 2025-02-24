import axios from 'axios';
import { AuthService } from './AuthService';

export const ApiService = {
    async get(path) {
        return axios.get(AuthService.getEndpoint() + path, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    async post(path, data) {
        return axios.post(AuthService.getEndpoint() + path, data, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    async put(path, data) {
        return axios.put(AuthService.getEndpoint() + path, data, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    async delete(path) {
        return axios.delete(AuthService.getEndpoint() + path, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    }
};
