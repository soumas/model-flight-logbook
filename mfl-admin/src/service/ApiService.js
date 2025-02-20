import axios from 'axios';
import { AuthService } from './AuthService';

export const ApiService = {
    async get(path) {
        return axios.get(AuthService.getEndpoint() + path, { headers: { accept: 'application/json', 'x-api-key': AuthService.getApikey() } });
        // return axios
        //     .get(pEndpoint + '/admin/checkauth', { headers: { accept: 'application/json', 'x-api-key': pApikey } })
        //     .then(function () {
        //         endpoint = pEndpoint;
        //         apikey = pApikey;
        //         router.push('/');
        //         return true;
        //     })
        //     .catch(function (reason) {
        //         console.log(reason);
        //         return false;
        //     });
    }
};
