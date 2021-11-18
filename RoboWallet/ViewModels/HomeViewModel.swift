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

    private let coinDataService: CoinDataService

    private var cancellables = Set<AnyCancellable>()

    init() {
        isLoading = true
        coinDataService = CoinDataService()
        addSubscribers()
    }

    func addSubscribers() {
        coinDataService.$allCoins
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

    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        HapticManager.notification(type: .success)
    }

}
