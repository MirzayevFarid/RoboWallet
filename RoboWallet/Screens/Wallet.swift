//
//  Wallet.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 30.11.2021.
//

import SwiftUI
import SwiftUIGIF
import Firebase

struct Wallet: View {
    @StateObject private var vm = WalletViewModel()

    @State private var selectedTab = 0

    var body: some View {
        VStack(alignment: .leading){

            HStack{
                Text("Wallet")
                    .font(Font.system(size: 32, weight: .bold))
                    .padding()

                Spacer()

                if !vm.portfolioCoins.isEmpty { NavigationStep(type: .sheet, style: .view) {
                    AddCoin()
                        .environmentObject(vm)
                } label: {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .padding(.trailing, 20)
                }
                }
            }

            RefreshableScrollView(action: vm.reloadData) {
                if vm.isLoading {
                    GIFImage(name: "btcGif")
                        .frame(height: 80)
                        .padding()
                }

                if vm.portfolioCoins.isEmpty { blankPortfolio }
                else { portfolioCoins }
            }.redacted(reason: (vm.isLoading) ? .placeholder : [])
        }
        .padding(.vertical)
        .background(BlurredBackground().ignoresSafeArea())
        .ignoresSafeArea()
    }
}

struct Wallet_Previews: PreviewProvider {
    static var previews: some View {
        Wallet()
            .preferredColorScheme(.dark)
    }
}


extension Wallet {
    private var blankPortfolio: some View {
        HStack{
            Text("Please Add Coin To Portfolio")
            NavigationStep(type: .sheet, style: .view) {
                AddCoin()
                    .environmentObject(vm)
            } label: {
                Image(systemName: "plus.rectangle.on.rectangle")
                    .padding(.trailing, 20)
            }
        }
    }


    private var portfolioCoins: some View {
        VStack(alignment: .leading){
            ForEach(Array(self.vm.portfolioCoins.enumerated()),
                    id: \.1.id) { (index, coin) in
                HStack{
                    WalletListCoinCard(coin: coin, coinNo: index+1)
                }
            }.padding(.top)
        }

    }
}

