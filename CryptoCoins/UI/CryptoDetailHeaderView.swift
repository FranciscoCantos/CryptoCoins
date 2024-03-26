import SwiftUI

struct CryptoDetailHeaderView: View {
    private let cryptoCurrency: CryptoCurrencyViewItem
    
    init(cryptoCurrency: CryptoCurrencyViewItem) {
        self.cryptoCurrency = cryptoCurrency
    }
    
    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text(cryptoCurrency.name)
                        .font(.title)
                    Text(cryptoCurrency.symbol.uppercased())
                        .font(.title)
                        .bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(cryptoCurrency.price)
                        .font(.title)
                    Text(cryptoCurrency.price24h)
                        .font(.headline)
                        .foregroundStyle(cryptoCurrency.isPositive ? .green : .red )
                }
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            
            HStack {
                Text("Market CAP:").font(.headline)
                Spacer()
                Text(cryptoCurrency.marketCap).font(.headline)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            HStack {
                Text("24h Vol:").font(.headline)
                Spacer()
                Text(cryptoCurrency.volume24h).font(.headline)
            }
        }
    }
}
