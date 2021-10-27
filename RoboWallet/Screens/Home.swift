//
//  Home.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import Foundation


import SwiftUI
import Firebase

struct Home: View {

    @EnvironmentObject private var userInfo: UserInfo
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {

        VStack(alignment: .leading) {
            Text("Home")
                .font(Font.system(size: 32, weight: .bold))
                .padding()


            // ACTION BUTTONS
            HStack(alignment: .top) {
                Spacer()
                Spacer()
                ActionCard(name: "Watchlist", icon: "star", color: "green", action: {})
                ActionCard(name: "Convert", icon: "repeat", color: "yellow", action: {})
                ActionCard(name: "Compare", icon: "square.on.square", color: "blue", action: {})
                ActionCard(name: "Price Alert", icon: "bolt", color: "purple", action: {})
            }



            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading){
                    // WALLET
                    Text("Your Wallet")
                        .padding(25)
                        .font(Font.system(size: 24))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(coinList, id: \.self) { coin in
                                CoinWalletCard(coin: coin)
                            }
                        }
                    }

                    // TRENDING
                    Text("Trending")
                        .padding(.leading, 25)
                        .font(Font.system(size: 24))
                        .padding(.top, 40)

                    ForEach(vm.allCoins) { coin in
                        ListCoinCard(coin: coin)
                    }.padding(.top)


                    Spacer(minLength: 80)

                }
                .background(Color("card2"))
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            }
        }
        .padding(.vertical)
        .background(BlurredBackground())
        .ignoresSafeArea()
        .onAppear {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            FBFirestore.retrieveFBUser(uid: uid) { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.userInfo.user = user
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
