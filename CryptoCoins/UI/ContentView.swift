import SwiftUI

struct ContentView: View {
    private let globalCryptoList: GlobalCryptoView
    private let cryptoListView: CryptoListView
    
    init(globalCryptoList: GlobalCryptoView, cryptoListView: CryptoListView) {
        self.globalCryptoList = globalCryptoList
        self.cryptoListView = cryptoListView
    }
    
    var body: some View {
        TabView {
            globalCryptoList.tabItem {
                Label("Global", systemImage: "list.dash")
            }
            cryptoListView.tabItem {
                Label("CryptoList", systemImage: "list.dash")
            }
        }
    }
}
