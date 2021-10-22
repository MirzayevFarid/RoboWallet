//
//  CustomField.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import SwiftUI

struct CustomInput: View {
    @Binding var text: String
    var icon = ""
    var color = ""
    var isSecure = false
    var placeHolder = ""

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(Font.body.weight(.bold))
                .foregroundColor(Color(color))
                .background(
                    Circle()
                        .fill(Color(color).opacity(0.2))
                        .frame(width: 30, height: 30)
                )
            if(isSecure){
                SecureField(placeHolder, text: $text)
                    .foregroundColor(.gray)
            }
            else{
                TextField(placeHolder, text: $text)
                    .foregroundColor(.gray)
            }
        }
    }
}
