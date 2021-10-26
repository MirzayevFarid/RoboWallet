//
//  Market.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 26.10.2021.
//


import SwiftUI


struct Market: View {
    private let selections = ["Popular", "Watchlist", "Trending"]
    @State var selection: Int = 0
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Market")
                    .font(Font.system(size: 32, weight: .bold))
                    .padding()

                Spacer()

                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 30))
                    .font(Font.body.weight(.bold))
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color("card"))
                            .frame(width: 60, height: 60)
                    )
                    .padding()
            }

            SegmentedPicker(items: self.selections, selection: self.$selection)
                .padding(5)

            ScrollView(showsIndicators: false) {
                switch selection {
                case 1:
                        VStack {
                            ForEach(coinList, id: \.self) { coin in
                                CoinCard(coin: coin)
                            }.padding(.top)
                        }
                        Spacer(minLength: 80)

                case 2:
                        VStack {
                            ForEach(coinList2, id: \.self) { coin in
                                CoinCard(coin: coin)
                            }.padding(.top)
                        }
                        Spacer(minLength: 80)

                default:
                        VStack {
                            ForEach(coinList3, id: \.self) { coin in
                                CoinCard(coin: coin)
                            }.padding(.top)
                        }
                        Spacer(minLength: 80)
                }
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
            .preferredColorScheme(.dark)
    }
}
