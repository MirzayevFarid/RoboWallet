//
//  PortfolioModel.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 24.11.2021.
//

import Foundation
import UIKit


struct PortfolioModel: Identifiable, Codable {

    let id: String
    let portfolioName: String
    let portfolioColor: String
    let portfolioCoins: [PortfolioCoinModel] = []
    let totalPortfolioValue: Int = 0
    let totalChangeRate: Double = 0

    init(portfolioName: String, portfolioColor: String) {
        self.id = UUID().uuidString
        self.portfolioName = portfolioName
        self.portfolioColor = portfolioColor
    }

//    init(portfolioName: String, portfolioColor: String, portfolioCoins: [PortfolioCoinModel]?, totalPortfolioValue: Int?, totalChangeRate: Double?) {
//        self.id = UUID().uuidString
//        self.portfolioName = portfolioName
//        self.portfolioColor = portfolioColor
//        self.portfolioCoins = portfolioCoins ?? []
//        self.totalPortfolioValue = totalPortfolioValue ?? 0
//        self.totalChangeRate = totalChangeRate ?? 0
//    }

    enum CodingKeys: String, CodingKey {
        case id
        case portfolioName
        case portfolioColor
        case portfolioCoins
        case totalPortfolioValue
        case totalChangeRate
    }

    static func dataDict(portfolio: PortfolioModel) -> [String: Any] {
        var data: [String: Any]
        data = [
            FBKeys.Portfolio.portfolioId: portfolio.id,
            FBKeys.Portfolio.portfolioCoins: portfolio.portfolioCoins,
            FBKeys.Portfolio.portfolioName: portfolio.portfolioName,
            FBKeys.Portfolio.portfolioColor: portfolio.portfolioColor,
            FBKeys.Portfolio.totalPortfolioValue: portfolio.totalPortfolioValue,
            FBKeys.Portfolio.totalChangeRate: portfolio.totalChangeRate,
        ]
        return data
    }
}

struct PortfolioCoinModel: Identifiable, Codable{
    let id = UUID()
    let amount: Double
    let coinId: String

    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case coinId
    }

}
