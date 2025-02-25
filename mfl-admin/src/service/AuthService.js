import axios from 'axios';
import router, { routes } from '../router/index';

export const AuthService = {
    login(pApikey) {
        console.info(this.getEndpoint());
        return axios
            .get(this.getEndpoint() + 'admin/checkauth', { headers: { accept: 'application/json', 'x-api-key': pApikey } })
            .then(function () {
                sessionStorage.setItem('apikey', pApikey);
                router.push(routes.dashboard);
                return true;
            })
            .catch(function (reason) {
                console.log(reason);
                return false;
            });
    },
    logout() {
        sessionStorage.removeItem('apikey');
        router.push(routes.login);
    },
    getEndpoint() {
        return import.meta.env.VITE_ENDPOINT;
    },
    getApikey() {
        return sessionStorage.getItem('apikey');
    }
};
