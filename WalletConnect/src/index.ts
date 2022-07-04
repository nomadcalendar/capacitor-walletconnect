import { registerPlugin } from '@capacitor/core';

import type { WallectConnectPlugin } from './definitions';

const WallectConnect = registerPlugin<WallectConnectPlugin>('WallectConnect', {
  web: () => import('./web').then(m => new m.WallectConnectWeb()),
});

export * from './definitions';
export { WallectConnect };
