//
//  MarketViewModel.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 27.10.2021.
//

import Foundation
import Combine
import SwiftUI

class MarketViewModel: ObservableObject {

    @Published var allCoins: [CoinModel] = []
    @Published var filteredCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false


    private let coinDataService: CoinDataService
    private let marketDataService: MarketDataService

    private var cancellables = Set<AnyCancellable>()

    init() {
        isLoading = true
        coinDataService = CoinDataService()
        marketDataService = MarketDataService()
        addSubscribers()
        isLoading = false
    }

    func addSubscribers() {
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)


        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.default){
                        self?.isLoading = false
                    }
                }
            }
            .store(in: &cancellables)
    }



    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
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

    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        guard let data = marketDataModel else {
            return stats
        }

        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)

        let portfolioValue =
        portfolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)

        let previousValue =
        portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue)

        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }

    
}
