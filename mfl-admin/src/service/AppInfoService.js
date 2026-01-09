
export const AppInfoService = {
    getVersion() {
        return import.meta.env.VITE_MFLADMINVERSION || 'unknown';
    },    
};
