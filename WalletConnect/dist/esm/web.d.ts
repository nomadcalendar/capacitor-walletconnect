import { WebPlugin } from '@capacitor/core';
import type { WallectConnectPlugin } from './definitions';
export declare class WallectConnectWeb extends WebPlugin implements WallectConnectPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
