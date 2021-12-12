//
//  CoinCard.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 27.10.2021.
//

import SwiftUI

struct MainListCoinCard: View {
    var coin: CoinModel
    var coinRank: Int?
    var body: some View {

        HStack(alignment: .center) {
            Text("\(coinRank ?? coin.rank)")
                .font(.caption)
                .foregroundColor(Color.secondary)
                .frame(minWidth: 30)

            CoinImageView(coin: coin)
                .frame(width: 40, height: 40)
                .padding(.trailing)

            VStack(alignment: .leading, spacing: 10) {
                Text(coin.symbol.uppercased())
                    .font(Font.body.weight(.bold))
                Text(coin.name)
                    .font(Font.body.weight(.bold)).foregroundColor(.gray)
            }

            Spacer()
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .font(Font.system(size: 20))
                    .font(Font.body.weight(.bold))
                HStack {

                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Text("▲").font(Font.body.weight(.bold))
                        .foregroundColor(.green)
                    :
                    Text("▼").font(Font.body.weight(.bold))
                        .foregroundColor(.red)

                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .font(Font.body.weight(.bold))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .background(
            Color.white.opacity(0.001)
        )
    }
}


struct WalletListCoinCard: View {
    var coin: CoinModel
    var coinNo: Int

    var gridItems = [GridItem(.fixed(120)), GridItem(.fixed(120)), GridItem(alignment: .trailing)    ]

    var body: some View {

        LazyVGrid(
            columns: gridItems,
            alignment: .leading,
            spacing: 5,
            pinnedViews: [],
            content: {

                HStack {
                    Text("\(coinNo)")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                        .frame(minWidth: 10)

                    CoinImageView(coin: coin)
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)

                    Text(coin.symbol.uppercased())
                        .font(Font.body.weight(.bold))
                }


                    VStack(alignment: .leading, spacing: 5) {
                        Text((coin.currentHoldings! * coin.currentPrice).asCurrencyWith6Decimals())
                            .font(Font.system(size: 16))
                            .foregroundColor(.gray)
                            .font(Font.body.weight(.bold))

                        Text((coin.currentHoldings!.asNumberString()))
                            .font(Font.system(size: 16))
                            .foregroundColor(.gray)
                            .font(Font.body.weight(.bold))
                    }


                VStack(alignment: .trailing, spacing: 5) {
                        Text(coin.currentPrice.asCurrencyWith6Decimals())
                            .font(Font.system(size: 16))
                            .font(Font.body.weight(.bold))
                        HStack {
                            (coin.priceChangePercentage24H ?? 0) >= 0 ?
                            Text("▲").font(Font.body.weight(.bold))
                                .foregroundColor(.green)
                            :
                            Text("▼").font(Font.body.weight(.bold))
                                .foregroundColor(.red)

                            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                                .font(Font.system(size: 16))
                                .font(Font.body.weight(.bold))
                                .foregroundColor(.gray)
                        }
                    }



            })
            .background(
                Color.white.opacity(0.001)
            )
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
    }
}
