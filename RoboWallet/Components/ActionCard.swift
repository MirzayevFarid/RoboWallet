//
//  ActionCard.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 24.10.2021.
//

import SwiftUI

struct ActionCard: View {
    var name: String
    var icon: String
    var color: String
    var action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                VStack(alignment: .center, spacing: 20) {
                    Image(systemName: icon)
                        .font(Font.system(size: 30))
                        .font(Font.body.weight(.bold))
                        .foregroundColor(Color(color))
                        .background(
                            Circle()
                                .fill(Color("card"))
                                .frame(width: 80, height: 80)
                        )
                        .frame(width: 80, height: 80)
                    Text(name)
                        .foregroundColor(.white)
                }
            }
            Spacer()
        }
    }
}
