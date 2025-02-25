import axios from 'axios';
import { AuthService } from './AuthService';

export const ApiService = {
    async get(path) {
        return axios.get(AuthService.getEndpoint() + this.normalizePath(path), { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    async post(path, data) {
        return axios.post(AuthService.getEndpoint() + this.normalizePath(path), data, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    async put(path, data) {
        return axios.put(AuthService.getEndpoint() + this.normalizePath(path), data, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    async delete(path) {
        return axios.delete(AuthService.getEndpoint() + this.normalizePath(path), { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
    },
    normalizePath(path) {
        if (path.startsWith('/')) {
            path = path.substring(1);
        }
        return path;
    }
};
