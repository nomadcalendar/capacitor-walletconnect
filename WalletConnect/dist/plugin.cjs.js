'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const WallectConnect = core.registerPlugin('WallectConnect', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.WallectConnectWeb()),
});

class WallectConnectWeb extends core.WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    WallectConnectWeb: WallectConnectWeb
});

exports.WallectConnect = WallectConnect;
//# sourceMappingURL=plugin.cjs.js.map
