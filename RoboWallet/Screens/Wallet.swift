//
//  Wallet.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 30.11.2021.
//

import SwiftUI
import Firebase
import SwiftUIGIF


struct Wallet: View {
    @StateObject private var vm = WalletViewModel()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Wallet")
                    .font(Font.system(size: 32, weight: .bold))
                    .padding()

                Spacer()

                if !vm.allCoins.isEmpty { NavigationStep(type: .sheet, style: .view) {
                    AddCoin()
                        .environmentObject(vm)
                } label: {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .padding(.trailing, 20)
                }
                }
            }


            SearchBarView(searchText: $vm.searchText)

            ScrollView(showsIndicators: false) {
                PortfolioCard().environmentObject(vm)

                portfolioCoins
                    .padding(.vertical)


                Spacer(minLength: 80)
            }
            .redacted(reason: (vm.isLoading) ? .placeholder : [])

            .ignoresSafeArea()

        }
        .padding(.vertical)
        .background(BlurredBackground())
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            vm.searchText = ""
        }
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
        HStack(alignment: .center)
        {
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
