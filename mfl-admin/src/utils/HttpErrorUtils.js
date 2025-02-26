import { AuthService } from '@/service/AuthService';

export function handleApiError(e, errorMsgRef) {
    console.error(e);

    if (e.status && (e.status == 401 || e.status == 403)) {
        AuthService.logout();
    }

    var msg = '<strong>Ein Fehler ist aufgetreten</strong><br/>';
    if (e.response != null && e.response.data != null && e.response.data.detail != null) {
        msg = msg + e.response.data.detail;
    } else if (e.message != null) {
        msg = msg + e.message;
    }
    errorMsgRef.value = msg;
}
