////
////  SortFilterBar.swift
////  RoboWallet
////
////  Created by Mirzayev Farid on 9.12.2021.
////
//
//import SwiftUI
//
//struct SortFilterBar: View {
//
//    var body: some View {
//        HStack {
//            HStack(spacing: 4) {
//                Text("Coin")
//                Image(systemName: "chevron.down")
//                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
//                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
//            }
//            .onTapGesture {
//                withAnimation(.default) {
//                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
//                }
//            }
//
//            Spacer()
//            if showPortfolio {
//                HStack(spacing: 4) {
//                    Text("Holdings")
//                    Image(systemName: "chevron.down")
//                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
//                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
//                }
//                .onTapGesture {
//                    withAnimation(.default) {
//                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
//                    }
//                }
//            }
//
//
//            HStack(spacing: 4) {
//                Text("Price")
//                Image(systemName: "chevron.down")
//                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
//                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
//            }
//            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
//            .onTapGesture {
//                withAnimation(.default) {
//                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
//                }
//            }
//
//            Button(action: {
//                withAnimation(.linear(duration: 2.0)) {
//                    vm.reloadData()
//                }
//            }, label: {
//                Image(systemName: "goforward")
//            })
//                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
//        }
//        .font(.caption)
//        .foregroundColor(Color.gray)
//        .padding(.horizontal)
//    }
//}
//
//
//
//
//struct SortFilterBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SortFilterBar()
//    }
//}
