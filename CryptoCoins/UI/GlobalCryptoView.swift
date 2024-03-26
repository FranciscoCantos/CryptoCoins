import SwiftUI

struct GlobalCryptoView: View {
    private let createCryptoDetailView: CreateCryptoDetailViewProtocol
    @ObservedObject private var viewModel: GlobalCryptoViewModel
    
    init(viewModel: GlobalCryptoViewModel, createCryptoDetailView: CreateCryptoDetailViewProtocol) {
        self.viewModel = viewModel
        self.createCryptoDetailView = createCryptoDetailView
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0, anchor: .center)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Button(errorMessage, role: .destructive) {
                        viewModel.onAppear()
                    }
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    NavigationStack {
                        List {
                            ForEach(viewModel.cryptos, id: \.id) { crypto in
                                NavigationLink {
                                    createCryptoDetailView.createView(cryptoCurrency: crypto)
                                } label: {
                                    CryptoItemView(item: crypto)
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }.refreshable {
            viewModel.onAppear()
        }
    }
}
