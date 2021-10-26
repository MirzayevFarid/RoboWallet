//
//  MockData.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//
import SwiftUI


struct coinSample: Codable, Hashable{
    var id = UUID()
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


let coinList2 = [
    coinSample(
        image: "bitcoinsign.circle",
        name: "BTCccc",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "ETHhhh",
        price: "$45000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "LTCccc",
        price: "$45000",
        rate: "2.15%"

    ),
]

let coinList3 = [
    coinSample(
        image: "bitcoinsign.circle",
        name: "BTCcccaaa",
        price: "$4",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "ETH",
        price: "$4000",
        rate: "2.15%"

    ),
    coinSample(
        image: "bitcoinsign.circle",
        name: "LTC",
        price: "$3500",
        rate: "2.15%"

    ),
]
