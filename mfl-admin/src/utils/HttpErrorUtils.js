import { AuthService } from '@/service/AuthService';

export function handleApiError(e, errorMsgRef) {
    console.error(e);

    if (e.status && (e.status == 401 || e.status == 403)) {
        AuthService.logout();
    }

    var msg = '<strong>Ein Fehler ist aufgetreten</strong><br/>';
    if (e.message != null) {
        msg = msg + e.message;
    }
    errorMsgRef.value = msg;
}
