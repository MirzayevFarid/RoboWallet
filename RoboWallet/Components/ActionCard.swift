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

    var body: some View {

        HStack {
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: icon)
                    .font(Font.system(size: 30))
                    .font(Font.body.weight(.bold))
                    .foregroundColor(Color(color))
                    .mask(Circle().fill(Color("card"))
                            .frame(width: 60, height: 60))
                    .frame(width: 60, height: 60)
                Text(name)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}
