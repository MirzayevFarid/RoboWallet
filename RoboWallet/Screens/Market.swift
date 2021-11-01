//
//  Market.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 26.10.2021.
//


import SwiftUI

struct Market: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {

            VStack(alignment: .leading){
                    Text("Market")
                        .font(Font.system(size: 32, weight: .bold))
                        .padding()

                SearchBarView(searchText: $vm.searchText)


                ScrollView(showsIndicators: false) {

                    ForEach(vm.allCoins) { coin in
                        ListCoinCard(coin: coin)
                    }.padding(.top)
                    Spacer(minLength: 80)

                }.ignoresSafeArea()
            }
            .padding(.vertical)
            .background(BlurredBackground())
            .ignoresSafeArea()
    }
}

struct Market_Previews: PreviewProvider {
    static var previews: some View {
        Market()
            .environmentObject(HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
