//
//  PrimaryButton.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

import SwiftUI

struct PrimaryButton: View {
    var text = "-"
    var action = {}

    var body: some View {
            Button(action: {
                self.action()
            }) {
                HStack {
                    Text(text)
                        .font(.system(size: 20, weight: Font.Weight.semibold))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical)
                        .accentColor(Color.white)
                        .background(Color("buttonColor"))
                        .cornerRadius(40)
                }
            }.padding(.vertical)
        }
    }

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton().preferredColorScheme(.dark)
    }
}
