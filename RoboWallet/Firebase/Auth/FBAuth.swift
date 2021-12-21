//
//  FBAuth.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 25.10.2021.

import SwiftUI
import FirebaseAuth
import CryptoKit
import AuthenticationServices

struct FBAuth {
    static func resetPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
        )}
    
    static func authenticate(withEmail email :String,
                             password:String,
                             completionHandler:@escaping (Result<Bool, EmailAuthError>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            var newError:NSError
            if let err = error {
                newError = err as NSError
                var authError:EmailAuthError?
                switch newError.code {
                case 17009:
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                completionHandler(.failure(authError!))
            } else {
                completionHandler(.success(true))
            }
        }
    }

    static func createUser(withEmail email:String,
                           name: String,
                           password:String,
                           completionHandler:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                completionHandler(.failure(err))
                return
            }
            guard let _ = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            let data = FBUserModel.dataDict(uid: authResult!.user.uid,
                                             name: name,
                                             email: authResult!.user.email!)
            
            FBFirestore.mergeFBUser(data, uid: authResult!.user.uid) { (result) in
                completionHandler(result)
            }
            completionHandler(.success(true))
        }
    }

    
    static func logout(completion: @escaping (Result<Bool, Error>) -> ()) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(.success(true))
        } catch let err {
            completion(.failure(err))
        }
    }


    enum ProviderType: String {
        case password
        case apple = "apple.com"
    }
    
    static func getProviders() -> [ProviderType] {
        var providers:[ProviderType] = []
        if let user = Auth.auth().currentUser {
            for data in user.providerData {
                if let providerType = ProviderType(rawValue: data.providerID) {
                    providers.append(providerType)
                }
            }
        }
        return providers
    }
    
    static func reauthenticateWithPassword(password: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
            user.reauthenticate(with: credential) { _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
    static func reauthenticateWithApple(idTokenString: String, nonce: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            user.reauthenticate(with: credential) { _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
    static func deleteUser(completion: @escaping (Result<Bool,Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
}
