//
//  PortfolioModel.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 24.11.2021.
//

import Foundation
import UIKit

struct PortfolioCoinModel: Identifiable, Codable{
    let id: String
    let amount: Double
    let coinId: String


    init(id: String, amount: Double, coinId: String) {
        self.id = UUID().uuidString
        self.amount = amount
        self.coinId = coinId
    }

    static func dataDict(portfolio: CoinModel) -> [String: Any] {
        var data: [String: Any]
        data = [
            FBKeys.Portfolio.id: portfolio.id,
            FBKeys.Portfolio.coinId: portfolio.id,
            FBKeys.Portfolio.amount: portfolio.currentHoldings,
        ]
        return data
    }

    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case coinId
    }
}
