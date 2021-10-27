//
//  HomeViewModel.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 27.10.2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {

        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }


    
}
