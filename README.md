# walletconnect

Wallect Connect Plugin

For Capacitor iOS, This plugin can be used for connecting any wallet app to Capacitor developed apps by providing the URL to initialising 

## Installation 

Plugin is developed for iOS, For installation 

```bash
npm install @capacitor-community/walletconnect
npx cap sync
```
 
If not installed by command line, Include the whole package by moving the folder of ios plugin to project folder.

## Usage

### WalletConnectPlugin
WalletConnectPlugin class is publicly declared and used for connecting any wallet app to Capacitor developed apps by providing the URL to initialising method.

### Class Functions
#### connect
Create connection from WalletConnect to Wallet apps of the choice which URL is provided.

Takes Bridging URL and CAPPluginCall as parameters and connect the WalletConnect to the Wallet of your choice (which ever you provide bridge URL String). Throw or handle the error from the ``CAPPluginCall``. Use the callback to handle return permissions.

- Parameter brigdeURL: String URL, Which can be obtained from the Wallet apps.
- Parameter call: CAPPluginCall

- Returns:
    - QRImage: If bridge connection dosen't work out for Wallet apps. It returns in the CAPPluginCall a QRImage to scan and connect the Wallet.
    - nil: If Connection is success

- Throws:
    - error: if URL is not valid or is unable to convert to valid URL.
    
```@objc func connect(brigdeURL: String, _call: CAPPluginCall) ```

#### disconnect
Disconnect the bridge between WalletConnect and Wallet

This will disconnect WalletConnect and Wallet of which BridgeURL provided. Returns void and no parameters required.

```@objc func disconnect()```

#### connectionSuccess
Bridging successfully connected

This will provide you notification when the bridge is successfully connected. Messageprovided in the ``CAPPluginCall``

- Parameter call: CAPPluginCall

```connectionSuccess```

#### connectionFailed
Bridge Connection Failed

This function calls when the bridge connection failed. Message is provided in the ``CAPPluginCall``

- Parameter call: CAPPluginCall

```connectionFailed```

### Delegate Functions

#### failedToConnect

When plugin connection fails this delegate calls.

```failedToConnect()```

#### didConnect

When Capacitor plugin connect this delegate function will call.

```didConnect()```

#### didDisconnect

When Capacitor plugin disconnects from wallet app, This delegate function calls.

```didDisconnect()```
