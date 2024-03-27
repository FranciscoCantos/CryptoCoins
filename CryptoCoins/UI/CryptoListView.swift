import SwiftUI

struct CryptoListView: View {
    @ObservedObject private var viewModel: CryptoListViewModel
    @State private var searchText: String = ""
    
    init(viewModel: CryptoListViewModel) {
        self.viewModel = viewModel
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
                                CryptoItemBasicView(item: crypto)
                            }
                        }.searchable(text: $searchText).onChange(of: searchText) { oldValue, newValue in
                            viewModel.search(cryptoName: newValue)
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
