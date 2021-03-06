//
//  Market.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 26.10.2021.
//


import SwiftUI
import SwiftUIGIF

struct Market: View {
    @StateObject private var vm = MarketViewModel()
    @State private var selectCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false

    var body: some View {
        VStack(alignment: .leading){
            Text("Market")
                .font(Font.system(size: 32, weight: .bold))
                .padding()
                .padding(.top, 10)

            SearchBarView(searchText: $vm.searchText)

            HomeStats()
                .environmentObject(vm)
                .redacted(reason: (vm.allCoins.count == 0 || vm.isLoading) ? .placeholder : [])


            RefreshableScrollView(action: vm.reloadData) {
                if vm.isLoading {
                    GIFImage(name: "btcGif")
                        .frame(height: 80)
                        .padding()
                }
                ForEach(vm.allCoins) { coin in
                    MainListCoinCard(coin: coin)
                        .onTapGesture {
                            segue(coin: coin)
                        }
                }.padding(.top)
                Spacer(minLength: 80)
            }
            .redacted(reason: (vm.allCoins.count == 0 || vm.isLoading) ? .placeholder : [])
            .ignoresSafeArea()

        }
        .padding(.vertical)
        .background(BlurredBackground())
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectCoin),
                isActive: $showDetailView,
                label: {
                    EmptyView()
                }
            )
        )
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            vm.searchText = ""
        }
    }


    private func segue(coin: CoinModel){
        selectCoin = coin
        showDetailView.toggle()
    }

}

struct Market_Previews: PreviewProvider {
    static var previews: some View {
        Market()
            .environmentObject(MarketViewModel())
            .preferredColorScheme(.dark)
    }
}
