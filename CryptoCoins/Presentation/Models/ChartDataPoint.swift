import Foundation

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}
