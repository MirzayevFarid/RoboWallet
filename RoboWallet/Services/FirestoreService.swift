//
//  FirestoreService.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 24.11.2021.
//

import Foundation
import Firebase


class FirestoreManager: ObservableObject {

    @Published var portfolios : [PortfolioModel] = []


    static func addPortfolio(uid: String, newPortfolio: PortfolioModel, completion: @escaping (Result<Bool, Error>) -> ()) {

        let data = PortfolioModel.dataDict(portfolio: newPortfolio)

        Firestore.firestore().collection(FBKeys.CollectionPath.users)
            .document(uid)
            .collection(FBKeys.CollectionPath.portfolios)
            .document("\(newPortfolio.id)")
            .setData(data, merge: true) { (err) in
                if let err = err {
                    completion(.failure(err))
                    return
                }
                completion(.success(true))
            }
    }


    func fetchPortfolios(uid: String){
        Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
            .collection(FBKeys.CollectionPath.portfolios)
            .getDocuments { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    return
                }
                self.portfolios = snapshot.documents.compactMap { documentSnapshot -> PortfolioModel? in
                    let documentData = documentSnapshot.data()
                    if
                        let portfolioId = documentData["portfolioId"] as? String,
                        let portfolioName = documentData["portfolioName"] as? String,
                        let portfolioColor = documentData["portfolioColor"] as? String,
                        let portfolioCoins = documentData["portfolioCoins"] as? [PortfolioCoinModel]
//                        let totalPortfolioValue = 0 as? Int,
//                        let totalChangeRate = 0 as? Double
                    {
                        return PortfolioModel(portfolioName: portfolioName, portfolioColor: portfolioColor)
                    } else {
                        return nil
                    }
                }
            }
    }


    static func getPortfolios(uid: String, completion: @escaping (PortfolioModel?) -> Void){
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
            .collection(FBKeys.CollectionPath.portfolios)


        reference.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            } else {
                let documents = snapshot!.documents
                let decoder = JSONDecoder()

                for eachDoc in documents {
                    var data = eachDoc.data()

                    for (key, value) in data {
                        if let value = value as? Date {
                            let formatter = DateFormatter()
                            data[key] = formatter.string(from: value)
                        }
                    }

                    if let newData = try?  JSONSerialization.data(withJSONObject: data, options: []) {
                        let newPortfolio = try? decoder.decode(PortfolioModel.self, from: newData)
                        completion(newPortfolio)
                    }

                }
            }
        }
    }
}
