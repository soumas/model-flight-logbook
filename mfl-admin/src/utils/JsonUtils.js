export const JsonUtils = {
    jsonDateRegex() {
        return /^(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})(T(?<hour>\d{2}):(?<minutes>\d{2}):(?<seconds>\d{2})\.(?<millis>\d+))?$/;
    },
    datesToStrings(objOrArr) {
        if (!Array.isArray(objOrArr)) {
            objOrArr = new Array(1).fill(objOrArr);
        }
        for (const obj of objOrArr) {
            for (const property in obj) {
                if (obj[property] instanceof Date) {
                    const offset = obj[property].getTimezoneOffset();
                    obj[property] = new Date(obj[property].getTime() - offset * 60 * 1000);
                    obj[property] = obj[property].toISOString().split('T')[0];
                }
            }
        }
    },
    stringsToDates(objOrArr) {
        if (!Array.isArray(objOrArr)) {
            objOrArr = new Array(1).fill(objOrArr);
        }
        for (const obj of objOrArr) {
            for (const property in obj) {
                if (typeof obj[property] === 'string') {
                    if (obj[property].match(this.jsonDateRegex())) {
                        const { year, month, day, hour, minutes, seconds } = this.jsonDateRegex().exec(obj[property]).groups;
                        obj[property] = new Date(parseInt(year), parseInt(month) - 1, parseInt(day), hour != null ? parseInt(hour) : null, minutes != null ? parseInt(minutes) : null, seconds != null ? parseInt(seconds) : null);
                    }
                }
            }
        }
    }
};
