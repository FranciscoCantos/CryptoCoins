import SwiftUI

struct GlobalCryptoView: View {
    @ObservedObject private var viewModel: GlobalCryptoViewModel
    
    init(viewModel: GlobalCryptoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3.0, anchor: .center)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    Button(errorMessage, role: .destructive) {
                        viewModel.onAppear()
                    }
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    List {
                        ForEach(viewModel.cryptos, id: \.id) {
                            CryptoItemView(item: $0)
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
