import Foundation

extension Double {
    func toCurrency() -> Double {
        let divisor = pow(10.0, Double(4))
        return (self * divisor).rounded() / divisor
    }
}
