//
//  BlurredBackground.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import SwiftUI


struct BlurredBackground: View {
    var body: some View {
        ZStack {
            Color("screen")
            Circle()
                .fill(Color("blur1"))
                .frame(width: 150, height: 150)
                .blur(radius: 150)
                .offset(x: -200, y: -150)

            Circle()
                .fill(Color("blur2"))
                .frame(width: 150, height: 150)
                .blur(radius: 150)
                .offset(x: 200, y: 250)
        }
    }
}

struct BlurredBackground_Previews: PreviewProvider {
    static var previews: some View {
        BlurredBackground()
    }
}
