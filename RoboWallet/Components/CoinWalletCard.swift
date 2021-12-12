//
//  CoinCard.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import SwiftUI

struct PortfolioCard: View {
    @EnvironmentObject var vm: WalletViewModel

    var body: some View {
        ZStack {
            Color.white.opacity(0.05)
                .blur(radius: 20)

            HStack(alignment: .top, spacing: 80) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Portfolio").font(Font.body.weight(.bold))
                    Text("\(vm.portfolioValue.asCurrencyWith2Decimals())")
                        .font(Font.system(size: 22))
                        .font(Font.body.weight(.bold))
                }
                VStack(spacing: 10) {
                    Image(systemName: "bitcoinsign.circle")
                        .font(Font.system(size: 25))
                        .font(Font.body.weight(.bold))
                        .foregroundColor(Color("yellow"))
                        .background(
                            Circle()
                                .fill(Color("yellow")).opacity(0.2)
                                .frame(width: 50, height: 50)
                        )

                    HStack {
                        (vm.percentageChange) >= 0 ?
                        Text("▲").font(Font.body.weight(.bold))
                            .foregroundColor(.green)
                        :
                        Text("▼").font(Font.body.weight(.bold))
                            .foregroundColor(.red)
                        Text(vm.percentageChange.asPercentString()).font(Font.body.weight(.bold))
                    }.padding(.vertical)
                }
                .padding(.top, 15)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 25)

        }
        .cornerRadius(25)
        .shadow(
            color: Color("buttonColor").opacity(0.2),
            radius: 5, x: -3, y: 0)
        .padding(.leading, 15)

    }
}


struct BlankPortfolioCard: View {

    @Binding var portfolioName: String
    @Binding var portfolioColor: String

    var body: some View {

        let colors = [
            #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
            #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1),
            #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),
            #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
            #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
            #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
            #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
            #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        ]

        let columns = [
            GridItem(.adaptive(minimum: 60))
        ]

        ZStack {
            Color.white.opacity(0.05)
                .blur(radius: 20)

            VStack(alignment: .leading) {
                Text("Enter Portfolio Name")
                TextField("New Portfolio", text: $portfolioName)
                    .padding(5)
                    .font(Font.body.weight(.bold))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                
                Divider()
                Text("Select Portfolio Color")

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(colors, id: \.self){ colors in
                        ZStack {
                            Circle()
                                .fill(Color(colors))
                                .frame(width: 40, height: 40)
                                .onTapGesture(perform: {
                                    UIApplication.shared.endEditing()

                                    withAnimation(.default, {
                                        portfolioColor = colors.toHexString()
                                    })

                                })
                                .padding(10)

                            if portfolioColor == colors.toHexString() {
                                Circle()
                                    .stroke(Color(colors), lineWidth: 5)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
                .padding(10)

            }
            .padding()
        }
        .cornerRadius(25)
        .shadow(
            color: Color("buttonColor").opacity(0.2),
            radius: 5, x: -3, y: 0)
        .padding(.leading, 15)

    }
}
