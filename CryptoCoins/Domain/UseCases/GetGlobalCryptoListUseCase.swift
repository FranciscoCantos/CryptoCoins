import Foundation

class GetGlobalCryptoListUseCase {
    private let repository: GlobalCryptoRepositoryType
    
    init(repository: GlobalCryptoRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CryptoCurrency], CryptoCurrencyDomainError> {
        let result = await repository.getGlobalCryptoList()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)
        }
        
        let sortedCryptoList = cryptoList.sorted { $0.marketCap > $1.marketCap }
        return .success(sortedCryptoList)
    }
}
