import axios from 'axios';
import router from '../router/index';

var endpoint;
var apikey;

export const AuthService = {
    login(pEndpoint, pApikey) {
        return axios
            .get(pEndpoint + '/admin/checkauth', { headers: { accept: 'application/json', 'x-api-key': pApikey } })
            .then(function () {
                endpoint = pEndpoint;
                apikey = pApikey;
                router.push('/');
                return true;
            })
            .catch(function (reason) {
                console.log(reason);
                return false;
            });
    },
    logout() {
        endpoint = null;
        apikey = null;
        router.push('/login');
    },
    getEndpoint() {
        return endpoint;
    },
    getApikey() {
        return apikey;
    }
};
