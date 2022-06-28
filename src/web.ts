import { WebPlugin } from '@capacitor/core';

import type { WallectConnectPlugin } from './definitions';

export class WallectConnectWeb extends WebPlugin implements WallectConnectPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
