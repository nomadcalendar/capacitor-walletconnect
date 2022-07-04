import Foundation
import Capacitor
import CoreImage.CIFilterBuiltins
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(WalletConnectPlugin)
public class WalletConnectPlugin: CAPPlugin {
    
    private var callIdentifier: String?
    private let walletConnect = WalletConnect()
    
    /// Create connection from WalletConnect to Wallet apps of the choice which URL is provided.
    ///
    /// Takes Bridging URL and CAPPluginCall as parameters and connect the WalletConnect to the Wallet of your choice (which ever you provide bridge URL String). Throw or handle the error from the ``CAPPluginCall``. Use the callback to handle return permissions.
    ///
    /// - Parameters
    ///     - brigdeURL: String URL, Which can be obtained from the Wallet apps.
    ///     - call: CAPPluginCall.
    ///
    /// - Returns:
    ///     - QRImage: If bridge connection dosen't work out for Wallet apps. It returns in the CAPPluginCall a QRImage to scan and connect the Wallet.
    ///     - nil: If Connection is success
    ///
    /// - Throws:
    ///     - error: if URL is not valid or is unable to convert to valid URL.
    @objc func connect(brigdeURL: String, _ call: CAPPluginCall) {
        self.walletConnect.delegate = self
        
        guard let url = URL.init(string: brigdeURL) else {
            call.reject("Unable to convert brigdeURL string to URL")
            return  }
        let connectionUrl = walletConnect.connect(bridgeURL: url)
        bridge?.saveCall(call)
        self.callIdentifier = call.callbackId
        let deepLinkUrl = "wc://wc?uri=\(connectionUrl)"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let url = URL(string: deepLinkUrl), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let data = Data(connectionUrl.utf8)
                let context = CIContext()
                let filter = CIFilter.qrCodeGenerator()
                filter.setValue(data, forKey: "inputMessage")

                let outputImage = filter.outputImage!
                let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
                let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent)!
                call.resolve(["qrImage": UIImage.init(cgImage: cgImage)])
            }
        }
    }
    
    /// Disconnect the bridge between WalletConnect and Wallet
    ///
    /// This will disconnect WalletConnect and Wallet of which BridgeURL provided. Returns void and no parameters required.
    @objc func disconnect() {
        walletConnect.disConnectWallet()
    }
    
    /// Bridging successfully connected
    ///
    /// This will provide you notification when the bridge is successfully connected. Message is provided in the ``CAPPluginCall``
    ///
    /// - Parameters
    ///     - call: CAPPluginCall
    @objc func connectionSuccess(_ call: CAPPluginCall) {
        call.resolve()
    }
    
    /// Bridge Connection Failed
    ///
    /// This function calls when the bridge connection failed. Message is provided in the ``CAPPluginCall``
    ///
    /// - Parameters
    ///     - call: CAPPluginCall
    @objc func connectionFailed(_ call: CAPPluginCall) {
        call.reject("Bridge connection failed.")
    }
}

extension WalletConnectPlugin: WalletConnectDelegate {
    func failedToConnect() {
        if let connectionID = self.callIdentifier, let call = bridge?.savedCall(withID: connectionID) {
            call.resolve(["message": "Connection failed."])
            self.connectionFailed(call)
        }
    }
    
    func didConnect() {
        if let connectionID = self.callIdentifier, let call = bridge?.savedCall(withID: connectionID) {
            call.resolve(["message": "Bridge successfully connected to Wallet"])
            self.connectionSuccess(call)
        }
    }
    
    /// didDisconnect Call when WalletConnect
    func didDisconnect() {
        if let callIdentifier = self.callIdentifier,
           let call = bridge?.savedCall(withID: callIdentifier) {
            call.resolve(["message": "Wallet disconnect"])
            bridge?.releaseCall(call)
        }
    }
}
