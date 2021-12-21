//
//  WalletViewModel.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 6.12.2021.
//

import Foundation
import Combine
import SwiftUI
import Firebase

class WalletViewModel: ObservableObject {
    @Published var portfolioCoins: [CoinModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var allCryptoCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var portfolioValue: Double = 0.0
    @Published var previousValue: Double = 0.0
    @Published var percentageChange: Double = 0.0

    private let coinDataService = CoinDataService()
    private let firestoreService = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()

    init() {
        isLoading = true
        addSubscribers()
        isLoading = false
    }

    func addSubscribers() {
        $searchText
            .combineLatest($allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)

        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCryptoCoins = returnedCoins
            }
            .store(in: &cancellables)
    
        coinDataService.$allCoins
            .combineLatest(firestoreService.$portfolioCoins)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = returnedCoins
                self.allCoins = returnedCoins


                self.portfolioValue =
                returnedCoins
                    .map({ $0.currentHoldingsValue })
                    .reduce(0, +)

                self.previousValue =
                returnedCoins
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingsValue
                        let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
                    }
                    .reduce(0, +)

                self.percentageChange = ((self.portfolioValue - self.previousValue) / self.previousValue)

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.default){
                        self.isLoading = false
                    }
                }
            }
            .store(in: &cancellables)

    }

    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioCoinModel]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinId == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }


    func updatePortfolio(coin: CoinModel, amount: Double) {
        if portfolioCoins.first(where: { $0.id == coin.id }) != nil {
            if amount > 0 {
                firestoreService.updateCoin(coin: coin, amount: amount)
            } else {
                firestoreService.deleteCoin(coin: coin)
            }
        } else {
            firestoreService.updateCoin(coin: coin, amount: amount)
        }
    }



    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        firestoreService.getPortfolio()
        HapticManager.notification(type: .success)
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {

        guard !text.isEmpty else {
            return coins
        }

        let lowercasedText = text.lowercased()

        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }

}


