import SwiftUI

struct CryptoItemBasicView: View {
    let item: CryptoCurrencyBasicViewItem
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.title3)
                Spacer()
                Text(item.symbol.uppercased())
                    .font(.headline)
                    .bold()
            }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        }
    }
}

#Preview {
    CryptoItemBasicView(item: CryptoCurrencyBasicViewItem(id: "Bitcoin", name: "Bitcoin", symbol: "BTC"))
}
