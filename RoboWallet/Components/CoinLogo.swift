//
//  CoinLogo.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 3.11.2021.
//

import SwiftUI

struct CoinLogoView: View {

    let coin: CoinModel

    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.gray)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}
