//
//  CoinConversionService.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 18.11.2021.
//

import Foundation
import Combine

class CoinConversionService {

    @Published var supportedCurrencies: [String] = []

    var supportedCoinsSubscription: AnyCancellable?

    init() {
        getCoinDetails()
    }

    func getCoinDetails() {
        guard let supportedCurrencies = URL(string: "https://api.coingecko.com/api/v3/simple/supported_vs_currencies") else { return }

        supportedCoinsSubscription = NetworkingManager.download(url: supportedCurrencies)
//        [String: Decodable].self
            .decode(type: [String].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedsupportedCurrencies) in
                self?.supportedCurrencies = returnedsupportedCurrencies
                self?.supportedCoinsSubscription?.cancel()
            })
    }
}

