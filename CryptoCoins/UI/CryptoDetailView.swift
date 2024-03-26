import SwiftUI
import Charts

struct CryptoDetailView: View {
    @ObservedObject private var viewModel: CryptoDetailViewModel
    @State private var selectedDays: DaysSelection = .month
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4),
                                                                    Color.accentColor.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                CryptoDetailHeaderView(cryptoCurrency: viewModel.cryptoCurrency)
                
                Picker("", selection: $selectedDays) {
                    ForEach(DaysSelection.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }.onChange(of: selectedDays) { oldValue, newValue in
                    viewModel.getPriceHistory(option: newValue)
                }.pickerStyle(.segmented)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .isHidden(viewModel.errorMessage != nil)
                
                Chart {
                    ForEach(viewModel.dataPoints) { data in
                        LineMark(x: .value("Date", data.date), y: .value("Price", data.price))
                    }
                    .interpolationMethod(.cardinal)
                    
                    ForEach(viewModel.dataPoints) { data in
                        AreaMark(x: .value("Date", data.date), y: .value("Price", data.price))
                    }
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(linearGradient)
                }
                .chartLegend(.visible)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                .isHidden(viewModel.errorMessage != nil)
            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .onAppear {
                viewModel.onAppear()
            }
            
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
                }
            }
        }
    }
}
