//
//  ContentView.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 23.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoggedIn = false
    @State var tabBarPages: [TabBarPage] = [
        TabBarPage(page: Home(), icon: "homekit", tag: "Home", color: .white),
        TabBarPage(page: Home(), icon: "chart.xyaxis.line", tag: "Analyze", color: .white),
        TabBarPage(page: Home(), icon: "bitcoinsign.circle", tag: "Profil", color: .white),
        TabBarPage(page: Home(), icon: "newspaper", tag: "News", color: .white),
        TabBarPage(page: Home(), icon: "person", tag: "Profile", color: .white),
    ]
    
    var body: some View {
        if(isLoggedIn){
            TabBarView(pages: $tabBarPages)        }
        else{
            Login()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
