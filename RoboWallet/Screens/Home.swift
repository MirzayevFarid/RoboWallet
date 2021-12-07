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


struct Home: View {

    @EnvironmentObject private var userInfo: UserInfo
    @StateObject private var vm = HomeViewModel()
    @StateObject private var fs = FirestoreManager()
    @State private var selectCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false

    var body: some View {

        VStack(alignment: .leading) {
            Text("Home")
                .font(Font.system(size: 32, weight: .bold))
                .padding()


            // ACTION BUTTONS
            HStack(alignment: .top) {
                Spacer()
                Spacer()

                NavigationStep(type: .sheet, style: .view) {
                    Converter()
                } label: {
                    ActionCard(name: "Watchlist", icon: "star", color: "green")
                }


                NavigationStep(type: .sheet, style: .view) {
                    Converter()
                } label: {
                    ActionCard(name: "Convert", icon: "repeat", color: "yellow")

                }

                NavigationStep(type: .sheet, style: .view) {
                    Converter()
                } label: {
                    ActionCard(name: "Compare", icon: "square.on.square", color: "blue")
                }


                NavigationStep(type: .sheet, style: .view) {
                    Converter()
                } label: {
                    ActionCard(name: "Price Alert", icon: "bolt", color: "purple")
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
