//
//  FBUser.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 25.10.2021.
//

import Foundation

struct FBUserModel {
    let uid: String
    let name: String
    let email: String

    init(uid: String, name: String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
    }

}

extension FBUserModel {
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let name = documentData[FBKeys.User.name] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""

        self.init(uid: uid,
                  name: name,
                  email: email
        )
    }

    static func dataDict(uid: String, name: String, email: String) -> [String: Any] {
        var data: [String: Any]

        // If name is not "" this must be a new entry so add all first time data
        if name != "" {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.name: name,
                FBKeys.User.email: email
            ]
        } else {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.email: email
            ]
        }
        return data
    }
}
