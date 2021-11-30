//
//  FBKeys.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 25.10.2021.
//

import Foundation

enum FBKeys {

    enum CollectionPath {
        static let users = "users"
        static let portfolios = "Portfolios"
    }

    enum User {
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
    }

    enum Portfolio {
        static let portfolioId = "portfolioId"
        static let portfolioName = "portfolioName"
        static let portfolioColor = "portfolioColor"
        static let portfolioCoins = "portfolioCoins"
        static let totalPortfolioValue = "totalPortfolioValue"
        static let totalChangeRate = "totalChangeRate"

    }

}
