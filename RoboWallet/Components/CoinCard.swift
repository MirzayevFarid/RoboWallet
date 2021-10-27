//
//  CoinCard.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 27.10.2021.
//

import SwiftUI

struct CoinCard: View {
    var coin: coinSample
    var body: some View {

        HStack(alignment: .center) {
            Image(systemName: coin.image)
                .font(Font.system(size: 30))
                .font(Font.body.weight(.bold))
                .foregroundColor(Color("yellow"))
                .background(
                    Circle()
                        .fill(Color("yellow").opacity(0.2))
                        .frame(width: 60, height: 60)
                )
                .frame(width: 60, height: 60)
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 10) {
                Text(coin.name)
                    .font(Font.body.weight(.bold))
                Text(coin.name)
                    .font(Font.body.weight(.bold)).foregroundColor(.gray)
            }

            Spacer()
            VStack(alignment: .trailing) {
                Text(coin.price)
                    .font(Font.system(size: 28))
                    .font(Font.body.weight(.bold))
                HStack {
                    Text("^").font(Font.body.weight(.bold))
                        .foregroundColor(.green)
                    Text(coin.rate).font(Font.body.weight(.bold))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}


struct ListCoinCard: View {
    var coin: CoinModel
    var body: some View {

        HStack(alignment: .center) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.secondary)
                .frame(minWidth: 30)
//
//            Image(systemName: "bitcoinsign.circle")
//                .font(Font.system(size: 30))
//                .font(Font.body.weight(.bold))
//                .foregroundColor(Color("yellow"))
//                .background(
//                    Circle()
//                        .fill(Color("yellow").opacity(0.2))
//                        .frame(width: 60, height: 60)
//                )
//                .frame(width: 60, height: 60)
//                .padding(.trailing, 10)


            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 10) {
                Text(coin.symbol.uppercased())
                    .font(Font.body.weight(.bold))
                Text(coin.name)
                    .font(Font.body.weight(.bold)).foregroundColor(.gray)
            }

            Spacer()
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .font(Font.system(size: 24))
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
    }
}