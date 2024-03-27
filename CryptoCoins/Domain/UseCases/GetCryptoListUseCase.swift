import Foundation

protocol GetCryptoListUseCaseProtocol {
    func execute() async -> Result<[CryptoCurrencyBasicInfo], DomainError>
}

class GetCryptoListUseCase: GetCryptoListUseCaseProtocol {
    private let repository: CryptoCurrencyRepositoryProtocol
    
    init(repository: CryptoCurrencyRepositoryProtocol) {
       self.repository = repository
   }
    
    func execute() async -> Result<[CryptoCurrencyBasicInfo], DomainError> {
        let result = await repository.getCryptoList()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        let sortedCryptoList = cryptoList.sorted { $0.name < $1.name }
        return .success(sortedCryptoList)
    }
}
