import { registerPlugin } from '@capacitor/core';
const WallectConnect = registerPlugin('WallectConnect', {
    web: () => import('./web').then(m => new m.WallectConnectWeb()),
});
export * from './definitions';
export { WallectConnect };
//# sourceMappingURL=index.js.map