//
//  ContentView.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userInfo: UserInfo

    @State var tabBarPages: [TabBarPage] = [
        TabBarPage(page: Home(), icon: "homekit", tag: "Home", color: .white),
        TabBarPage(page: Market(), icon: "chart.xyaxis.line", tag: "Analyze", color: .white),
        TabBarPage(page: Home(), icon: "bitcoinsign.circle", tag: "Profil", color: .white),
        TabBarPage(page: Converter(), icon: "repeat", tag: "Conversion", color: .white),
        TabBarPage(page: Profile(), icon: "person", tag: "Profile", color: .white),
    ]
    
    var body: some View {
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading...")
            } else if userInfo.isUserAuthenticated == .signedOut {
                Login()
            } else {
                TabBarView(pages: $tabBarPages)
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
