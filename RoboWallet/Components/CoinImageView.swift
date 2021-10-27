//
//  CoinImageView.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 28.10.2021.
//

import SwiftUI


struct CoinImageView: View {

    @StateObject var vm: CoinImageViewModel


    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }


    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if vm.isLoading {
                ProgressView()
            }else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.secondary)
            }
        }
    }
}
