#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(WalletConnectPlugin, "WallectConnect",
           CAP_PLUGIN_METHOD(connect, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(disconnect, CAPPluginReturnNone);
           CAP_PLUGIN_METHOD(connectionFailed, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(connectionSuccess, CAPPluginReturnPromise);
)
