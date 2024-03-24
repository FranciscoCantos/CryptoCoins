import Foundation

protocol GetGlobalCryptoListUseCaseProtocol {
    func execute() async -> Result<[CryptoCurrency], DomainError>
}

class GetGlobalCryptoListUseCase: GetGlobalCryptoListUseCaseProtocol {
    private let repository: GlobalCryptoRepositoryProtocol
    
    init(repository: GlobalCryptoRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CryptoCurrency], DomainError> {
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
