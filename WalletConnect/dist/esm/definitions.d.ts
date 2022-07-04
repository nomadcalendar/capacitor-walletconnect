export interface WallectConnectPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
