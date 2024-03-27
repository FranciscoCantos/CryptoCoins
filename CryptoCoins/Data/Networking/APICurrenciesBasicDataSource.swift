//
//  APICurrenciesBasicDataSource.swift
//  CryptoCoins
//
//  Created by Kurro on 26/3/24.
//

import Foundation

protocol APICurrenciesBasicDataSourceProtocol {
    func getBasicCryptoCurrencies() async -> Result<[CryptoCurrencyBasicDTO], HTTPClientError>
}
