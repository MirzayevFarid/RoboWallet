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
        static let id = "id"
        static let amount = "amount"
        static let coinId = "coinId"
    }
}
