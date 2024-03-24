//
//  CryptoItemView.swift
//  CryptoCoins
//
//  Created by Kurro on 24/3/24.
//

import SwiftUI

struct CryptoItemView: View {
    let item: CryptoCurrencyViewItem
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title3)
                        .lineLimit(1)
                    Text(item.symbol.uppercased())
                        .font(.headline)
                        .bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.price)
                        .font(.headline)
                        .lineLimit(1)
                    Text(item.price24h)
                        .font(.headline)
                        .foregroundColor(item.isPositive ? .green : .red)
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Market Cap:")
                        .font(.system(size: 10))
                        .lineLimit(1)
                    Text("24h:")
                        .font(.system(size: 10))
                        .bold()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(item.marketCap)
                        .font(.system(size: 10))
                        .lineLimit(1)
                    Text(item.volume24h)
                        .font(.system(size: 10))
                        .bold()
                }
            }
        }
    }
}

#Preview {
    CryptoItemView(item: CryptoCurrencyViewItem(model: CryptoCurrency(id: "21",
                                                                      name: "KurroCoin",
                                                                      symbol: "KRR",
                                                                      price: 23,
                                                                      price24h: 0.83,
                                                                      volume24h: 0.56,
                                                                      marketCap: 2345)))
}
