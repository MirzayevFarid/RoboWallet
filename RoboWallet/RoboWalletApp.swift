//
//  RoboWalletApp.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

import SwiftUI
import Firebase
import NavigationKit

@main
struct RoboWalletApp: App {

    @StateObject private var userInfo = UserInfo()
    @StateObject private var vm = HomeViewModel()

    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(userInfo)
                    .environmentObject(vm)
            }
            .statusBar(hidden: true)
            .navigationBarHidden(true)
        }
    }
}
