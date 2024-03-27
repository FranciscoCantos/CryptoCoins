import Foundation

extension Double {
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        
        return formatter.string(from: NSNumber(floatLiteral: self))
    }
    
    func toTwoDigitsFormat() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(floatLiteral: self))
    }
}
