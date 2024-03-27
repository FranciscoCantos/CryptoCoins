import Foundation
import SwiftData

protocol SwiftDataContainerProtocol {
    func fetchCryptos() -> [CryptoCurrencyInfoBasicData]
    func insertCryptos(_ cryptos: [CryptoCurrencyInfoBasicData]) async
}

class SwiftDataContainer: SwiftDataContainerProtocol {
    private static let sharedInstance = SwiftDataContainer()

    private let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        let schema = Schema([CryptoCurrencyInfoBasicData.self])
        container = try! ModelContainer(for: schema, configurations: [])
        context = ModelContext(container)
    }
    
    static func shared() -> SwiftDataContainer {
        return sharedInstance
    }
    
    func fetchCryptos() -> [CryptoCurrencyInfoBasicData] {
        let descriptor = FetchDescriptor<CryptoCurrencyInfoBasicData>()
        guard let cryptos = try? context.fetch(descriptor) else {
            return []
        }
        
        return cryptos
    }
    
    // KURRO todo manage errors
    
    func insertCryptos(_ cryptos: [CryptoCurrencyInfoBasicData]) async {
        cryptos.forEach {
            context.insert($0)
        }
        
        try? context.save()
    }
}
