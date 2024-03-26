import SwiftUI

@main
struct CryptoCoinsApp: App {
    var body: some Scene {
        WindowGroup {
            GlobalCryptoFactory().createView()
        }
    }
}
