//
//  Wallet.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 30.11.2021.
//

import SwiftUI
import SwiftUIGIF

struct Wallet: View {
    @StateObject private var fs = FirestoreManager()
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        ZStack{
            RefreshableScrollView(action: vm.reloadData) {
                if vm.isLoading {
                    GIFImage(name: "btcGif")
                        .frame(height: 80)
                        .padding()
                }
                VStack(alignment: .leading){
                    // WALLET
                    HStack{
                        Text("Your Portfolios")
                            .padding(25)
                            .font(Font.system(size: 24))
                        Spacer()

                        NavigationStep(type: .sheet, style: .view) {
                            AddPortfolio()
                                .environmentObject(fs)
                        } label: {
                            Image(systemName: "plus.rectangle.on.rectangle")
                                .padding(.trailing, 20)
                        }
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(fs.portfolios, id: \.id) { item in
                            CoinWalletCard(portfolio: item)
                        }
                    }.padding(.trailing)
                }
            }
        }
        .background(BlurredBackground().ignoresSafeArea())
    }
}

struct Wallet_Previews: PreviewProvider {
    static var previews: some View {
        Wallet()
            .preferredColorScheme(.dark)
    }
}
