//
//  CoinCard.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import SwiftUI

struct PortfolioCard: View {
    @EnvironmentObject var vm: WalletViewModel

    var body: some View {
        ZStack {
            Color.white.opacity(0.05)
                .blur(radius: 20)

            HStack(alignment: .top, spacing: 80) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Portfolio").font(Font.body.weight(.bold))
                    Text("\(vm.portfolioValue.asCurrencyWith2Decimals())")
                        .font(Font.system(size: 22))
                        .font(Font.body.weight(.bold))
                }
                VStack(spacing: 10) {
                    Image(systemName: "bitcoinsign.circle")
                        .font(Font.system(size: 25))
                        .font(Font.body.weight(.bold))
                        .foregroundColor(Color("yellow"))
                        .background(
                            Circle()
                                .fill(Color("yellow")).opacity(0.2)
                                .frame(width: 50, height: 50)
                        )

                    HStack {
                        (vm.percentageChange) >= 0 ?
                        Text("▲").font(Font.body.weight(.bold))
                            .foregroundColor(.green)
                        :
                        Text("▼").font(Font.body.weight(.bold))
                            .foregroundColor(.red)
                        Text(vm.percentageChange.asPercentString()).font(Font.body.weight(.bold))
                    }.padding(.vertical)
                }
                .padding(.top, 15)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 25)

        }
        .cornerRadius(25)
        .shadow(
            color: Color("buttonColor").opacity(0.2),
            radius: 5, x: -3, y: 0)
        .padding(.leading, 15)

    }
}
