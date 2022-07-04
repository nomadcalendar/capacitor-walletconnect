import Foundation
import WalletConnectSwift

@objc protocol WalletConnectDelegate {
    func failedToConnect()
    func didConnect()
    func didDisconnect()
}
// URL(string: "wss://bridge.aktionariat.com:8887")!
@objc class WalletConnect: NSObject {
    var client: Client!
    var session: Session!
    var delegate: WalletConnectDelegate!

    let sessionKey = "sessionKey"

    func intialise(delegate: WalletConnectDelegate) {
        self.delegate = delegate
    }

    @objc func connect(bridgeURL: URL) -> String {
        let wcUrl =  WCURL(topic: UUID().uuidString,
                           bridgeURL: bridgeURL,
                           key: try! randomKey())
        let clientMeta = Session.ClientMeta(name: "ExampleDApp",
                                            description: "WalletConnectSwift",
                                            icons: [],
                                            url: URL(string: "https://safe.gnosis.io")!)
        let dAppInfo = Session.DAppInfo(peerId: UUID().uuidString,
                                        peerMeta: clientMeta)
        client = Client(delegate: self, dAppInfo: dAppInfo)

        print("WalletConnect URL: \(wcUrl.absoluteString)")

        try! client.connect(to: wcUrl)
        return wcUrl.absoluteString
    }

    @objc func reconnectIfNeeded() {
        if let oldSessionObject = UserDefaults.standard.object(forKey: sessionKey) as? Data,
            let session = try? JSONDecoder().decode(Session.self, from: oldSessionObject) {
            client = Client(delegate: self, dAppInfo: session.dAppInfo)
            try? client.reconnect(to: session)
        }
    }

    private func randomKey() throws -> String {
        var bytes = [Int8](repeating: 0, count: 32)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        if status == errSecSuccess {
            return Data(bytes: bytes, count: 32).toHexString()
        } else {
            // we don't care in the example app
            enum TestError: Error {
                case unknown
            }
            throw TestError.unknown
        }
    }
    
    func disConnectWallet() {
        guard let session = session else { return }
        try? client.disconnect(from: session)
    }
}

extension WalletConnect: ClientDelegate {
    func client(_ client: Client, didFailToConnect url: WCURL) {
        delegate.failedToConnect()
    }

    func client(_ client: Client, didConnect url: WCURL) {
        // do nothing
    }

    func client(_ client: Client, didConnect session: Session) {
        self.session = session
        let sessionData = try! JSONEncoder().encode(session)
        UserDefaults.standard.set(sessionData, forKey: sessionKey)
        delegate.didConnect()
    }

    func client(_ client: Client, didDisconnect session: Session) {
        UserDefaults.standard.removeObject(forKey: sessionKey)
        delegate.didDisconnect()
    }

    func client(_ client: Client, didUpdate session: Session) {
        // do nothing
    }
}
