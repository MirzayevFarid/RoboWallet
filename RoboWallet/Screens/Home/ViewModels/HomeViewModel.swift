//
//  HomeViewModel.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 17.11.2021.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var trendingCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @EnvironmentObject var userInfo: UserInfo
    @Published var sortOption: SortOption = .change

    private let coinDataService: CoinDataService
    private var cancellables = Set<AnyCancellable>()

    enum SortOption {
        case rank, rankReversed, change, changeReversed
    }

    init() {
        isLoading = true
        coinDataService = CoinDataService()
        addSubscribers()
    }

    func addSubscribers() {
        coinDataService.$allCoins
            .combineLatest($sortOption)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.trendingCoins = returnedCoins.sorted(by: {$0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0} )
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.default){
                        self?.isLoading = false
                    }
                }
            }
            .store(in: &cancellables)
        isLoading = false
    }


    private func filterAndSortCoins(coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = coins
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }

    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .change:
            coins.sort(by: {$0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0})
        case .changeReversed:
            coins.sort(by: {$0.priceChangePercentage24H ?? 0 < $1.priceChangePercentage24H ?? 0})
        }
    }

    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        HapticManager.notification(type: .success)
    }
}
