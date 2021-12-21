//
//  FBFireStoreError.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 25.10.2021.
//

import Foundation


enum FireStoreError: Error {
    case noAuthDataResult
    case noCurrentUser
    case noDocumentSnapshot
    case noSnapshotData
    case noUser
}

extension FireStoreError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noAuthDataResult:
            return NSLocalizedString("No Auth Data Result", comment: "")
        case .noCurrentUser:
            return NSLocalizedString("No Current User", comment: "")
        case .noDocumentSnapshot:
            return NSLocalizedString("No Document Snapshot", comment: "")
        case .noSnapshotData:
            return NSLocalizedString("No Snapshot Data", comment: "")
        case .noUser:
            return NSLocalizedString("No User", comment: "")
        }
    }
}
