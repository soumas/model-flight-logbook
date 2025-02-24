import axios from 'axios';
import router from '../router/index';

export const AuthService = {
    login(pEndpoint, pApikey) {
        return axios
            .get(pEndpoint + '/admin/checkauth', { headers: { accept: 'application/json', 'x-api-key': pApikey } })
            .then(function () {
                localStorage.setItem('endpoint', pEndpoint);
                localStorage.setItem('apikey', pApikey);
                router.push('/');
                return true;
            })
            .catch(function (reason) {
                console.log(reason);
                return false;
            });
    },
    logout() {
        localStorage.removeItem('endpoint');
        localStorage.removeItem('apikey');
        router.push('/login');
    },
    getEndpoint() {
        return localStorage.getItem('endpoint');
    },
    getApikey() {
        return localStorage.getItem('apikey');
    }
};
