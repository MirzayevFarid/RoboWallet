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
    @State private var showDetailView: Bool = false
    @State private var selectCoin: CoinModel? = nil

    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Wallet")
                    .font(Font.system(size: 32, weight: .bold))
                    .padding()


                Spacer()

                NavigationStep(type: .sheet, style: .view) {
                    AddCoin()
                        .environmentObject(vm)
                } label: {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .padding(.trailing, 20)
                }

            }.padding(.top, 10)


            if(vm.portfolioCoins.isEmpty) {blankPortfolio}
            else {portfolioView}


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
        VStack{
        Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
            .font(.callout)
            .foregroundColor(Color.white)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
            Spacer()
        }
    }

    private var portfolioCoins: some View {
        VStack(alignment: .leading){
            ForEach(Array(self.vm.portfolioCoins.enumerated()),
                    id: \.1.id) { (index, coin) in
                HStack{
                    WalletListCoinCard(coin: coin, coinNo: index+1)
                        .onTapGesture {
                            selectCoin = coin
                            showDetailView.toggle()
                        }
                }
            }.padding(.top)
        }
    }

    private var portfolioView: some View {
        Group{
            SearchBarView(searchText: $vm.searchText)

            RefreshableScrollView(action: vm.reloadData) {
                if vm.isLoading {
                    GIFImage(name: "btcGif")
                        .frame(height: 80)
                        .padding()
                }

                PortfolioCard().environmentObject(vm)
                    .padding(.trailing)

                portfolioCoins
                    .background(
                        NavigationLink(
                            destination: DetailLoadingView(coin: $selectCoin),
                            isActive: $showDetailView,
                            label: {
                                EmptyView()
                            }
                        )
                    )
                    .padding(.vertical)


                Spacer(minLength: 80)
            }
            .redacted(reason: (vm.isLoading) ? .placeholder : [])
            .ignoresSafeArea()
        }
    }

}
