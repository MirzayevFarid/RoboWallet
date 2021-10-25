//
//  Profile.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 25.10.2021.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        PrimaryButton(text: "LOG OUT", action: {
            FBAuth.logout { (result) in
                print("Logged Out")
            }
        })
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
