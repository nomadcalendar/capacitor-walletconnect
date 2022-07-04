var capacitorWallectConnect = (function (exports, core) {
    'use strict';

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

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
