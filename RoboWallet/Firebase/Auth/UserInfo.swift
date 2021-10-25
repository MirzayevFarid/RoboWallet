//
//  UserInfo.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 25.10.2021.

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    @Published var isUserAuthenticated: FBAuthState = .undefined
    @Published var user: FBUser = .init(uid: "", name: "", email: "")

    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?

    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
        })
    }
}
