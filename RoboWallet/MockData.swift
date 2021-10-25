//
//  MockData.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//
import SwiftUI


struct coinSample: Codable, Hashable{
    let image: String
    let name: String
    let price: String
    let rate: String
}

let coinList = [
    coinSample(
        image: "bitcoinsign.circle",
        name: "BTC",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "ETH",
        price: "$45000",
        rate: "2.15%"

    ),
coinSample(
        image: "bitcoinsign.circle",
        name: "LTC",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "BTC",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "ETH",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "BTC",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "ETH",
        price: "$45000",
        rate: "2.15%"

    ),
]
