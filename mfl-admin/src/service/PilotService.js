export const PilotService = {
    getPilotsData() {
        return [
            {
                id: '0012833868',
                phonenumber: '+4366488501741',
                active: true,
                acRegistrationValidTo: '2026-05-03',
                lastname: 'Juen',
                firstname: 'Thomas',
                email: 'thomas.juen@gmail.com',
                acIsUtmOperator: true,
                acPilotlicenseValidTo: '2026-05-03'
            },
            {
                id: '0013277282',
                phonenumber: '+4366488501741',
                active: true,
                acRegistrationValidTo: '2028-05-03',
                lastname: 'Eins',
                firstname: 'Testpilot',
                email: 'thomas.juen@gmail.com',
                acIsUtmOperator: true,
                acPilotlicenseValidTo: '2028-03-01'
            },
            {
                id: '0015495938',
                phonenumber: '+4366488501741',
                active: true,
                acRegistrationValidTo: '2028-05-03',
                lastname: 'Zwei',
                firstname: 'Testpilot',
                email: 'thomas.juen@gmail.com',
                acIsUtmOperator: true,
                acPilotlicenseValidTo: '2025-03-01'
            },
            {
                id: '0012798711',
                phonenumber: '+4366488501741',
                active: true,
                acRegistrationValidTo: '2028-05-03',
                lastname: 'Drei',
                firstname: 'Testpilot',
                email: 'thomas.juen@gmail.com',
                acIsUtmOperator: false,
                acPilotlicenseValidTo: '2028-02-01'
            },
            {
                id: '0012766355',
                phonenumber: '+4366488501741',
                active: true,
                acRegistrationValidTo: '2025-01-05',
                lastname: 'Vier',
                firstname: 'Testpilot',
                email: 'thomas.juen@gmail.com',
                acIsUtmOperator: true,
                acPilotlicenseValidTo: '2027-03-01'
            }
        ];
    },

    getPilots() {
        return Promise.resolve(this.getPilotsData());
    }
};
