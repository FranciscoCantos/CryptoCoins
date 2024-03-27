import SwiftUI

@main
struct CryptoCoinsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(globalCryptoList: GlobalCryptoFactory().createView(),
                        cryptoListView: CryptoListFactory().createView())
        }
    }
}
