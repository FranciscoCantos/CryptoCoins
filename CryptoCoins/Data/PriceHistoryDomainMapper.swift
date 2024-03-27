import Foundation

class PriceHistoryDomainMapper {    
    func map(model: PriceHistoryDTO) -> PriceHistory {
        let dataPoints: [PriceHistory.DataPoint] = model.prices.compactMap { dataPoint in
            
            guard dataPoint.count >= 2,
                  let date = timestampToDate(dataPoint[0]) else { return nil }
            
            return PriceHistory.DataPoint(price: dataPoint[1],
                                          date: date)
        }
        
        return PriceHistory(prices: dataPoints)
    }
    
    private func timestampToDate(_ timestamp: Double) -> Date? {
        let components = Calendar.current.dateComponents([.day, .month, .year],
                                                         from: Date(timeIntervalSince1970: timestamp / 1000))
        
        guard let date = Calendar.current.date(from: components) else { return nil }
        
        return date
    }
}
