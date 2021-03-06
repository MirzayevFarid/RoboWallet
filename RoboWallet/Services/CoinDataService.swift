//
//  CoinDataService.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 27.10.2021.
//

import Foundation
import Combine


class CoinDataService {

    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    func getCoins() {

        guard let allCoinsUrl = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else {return}


        coinSubscription = NetworkingManager.download(url: allCoinsUrl)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
