//
//  XMarkButton.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 3.11.2021.
//

import SwiftUI

struct XMarkButton: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        NavigationDismissStep(style: .button, presentationMode: presentationMode, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
