//
//  Home.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import Foundation


import SwiftUI
import Firebase
import SwiftUIGIF
import AlertToast


struct Home: View {

    @EnvironmentObject private var userInfo: UserInfo
    @StateObject private var vm = HomeViewModel()
    @StateObject private var fs = FirestoreManager()
    @State private var selectCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showToast = false

    var body: some View {

        VStack(alignment: .leading) {
            Text("Home")
                .font(Font.system(size: 32, weight: .bold))
                .padding()
                .padding(.top, 10)


            // ACTION BUTTONS
            HStack(alignment: .top) {
                Spacer()
                Spacer()


                ActionCard(name: "Watchlist", icon: "star", color: "green").onTapGesture {
                    showToast.toggle()
                }

                ActionCard(name: "Convert", icon: "repeat", color: "yellow").onTapGesture {
                    showToast.toggle()
                }
                ActionCard(name: "Compare", icon: "square.on.square", color: "blue").onTapGesture {
                    showToast.toggle()
                }
                ActionCard(name: "Price Alert", icon: "bolt", color: "purple").onTapGesture {
                    showToast.toggle()
                }
            }


            RefreshableScrollView(action: vm.reloadData) {
                if vm.isLoading {
                    GIFImage(name: "btcGif")
                        .frame(height: 80)
                        .padding()
                }
                VStack(alignment: .leading){
                    // TRENDING
                    Text("Trending")
                        .padding(.leading, 25)
                        .font(Font.system(size: 24))
                        .padding(.top, 40)


                    ForEach(Array(self.vm.trendingCoins.enumerated()),
                            id: \.1.id) { (index, coin) in
                        MainListCoinCard(coin: coin, coinRank: index+1)
                            .onTapGesture {
                                segue(coin: coin)
                            }
                    }.padding(.top)


                    Spacer(minLength: 80)

                }
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            }
            .redacted(reason: vm.trendingCoins.count == 0 || vm.isLoading ? .placeholder : [])
        }
        .toast(isPresenting: $showToast){
            AlertToast(type: .complete(Color.green), title: "Coming Sooooon!")
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


    private func segue(coin: CoinModel){
        selectCoin = coin
        showDetailView.toggle()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
