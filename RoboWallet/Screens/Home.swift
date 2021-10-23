//
//  Home.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import Foundation


import SwiftUI

struct Home: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Home")
                .font(Font.system(size: 32, weight: .bold))
                .padding()


            HStack(alignment: .top) {
                Spacer()
                Spacer()
                ActionCard(name: "Watchlist", icon: "star", color: "green", action: {})
                ActionCard(name: "Convert", icon: "repeat", color: "yellow", action: {})
                ActionCard(name: "Compare", icon: "square.on.square", color: "blue", action: {})
                ActionCard(name: "Price Alert", icon: "bolt", color: "purple", action: {})
            }


            VStack(alignment: .leading){
                Text("Your Wallet")
                    .padding(25)
                    .font(Font.system(size: 24))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(coinList, id: \.self) { coin in
                            CoinCard(coin: coin)
                        }
                    }
                }
                Spacer()

            }
            .background(Color("card2"))
            .cornerRadius(40, corners: [.topLeft, .topRight])
            .ignoresSafeArea()

        }
        .padding(.vertical)

        .frame(width: screenWidth, height: screenHeight)
        .background(BlurredBackground())
        .ignoresSafeArea()
    }
}





struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}
