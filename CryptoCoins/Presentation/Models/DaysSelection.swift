import Foundation

enum DaysSelection: String, CaseIterable {
    case week = "7 Day"
    case month = "30 Days"
    case treeMonth = "90 Days"
    case sixMonth = "180 Days"
    case oneYear = "1 Year"
    
    var intValue: Int {
        switch self {
        case .week:
            7
        case .month:
            30
        case .treeMonth:
            90
        case .sixMonth:
            180
        case .oneYear:
            365
        }
    }
}
