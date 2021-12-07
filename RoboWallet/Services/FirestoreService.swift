import Foundation
import Firebase


class FirestoreManager: ObservableObject {

    @Published var portfolioCoins : [PortfolioCoinModel] = []

    init(){
        getPortfolios()
    }

    func getPortfolios(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
            .collection(FBKeys.CollectionPath.portfolios)
            .getDocuments { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    return
                }
                self.portfolioCoins = snapshot.documents.compactMap { documentSnapshot -> PortfolioCoinModel? in
                    let documentData = documentSnapshot.data()
                    if
                        let id =  documentData["id"] as? String,
                        let coinId = documentData["coinId"] as? String,
                        let amount = documentData["amount"] as? Double
                    {
                        return PortfolioCoinModel(id: id, amount: amount, coinId: coinId)
                    } else {
                        return nil
                    }
                }
            }
    }



    func addCoin(newCoin: CoinModel, amount: Double) {

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let data = [
            "id": newCoin.id,
            "coinId": newCoin.id,
            "amount": amount,
        ] as [String : Any]

        Firestore.firestore().collection(FBKeys.CollectionPath.users)
            .document(uid)
            .collection(FBKeys.CollectionPath.portfolios)
            .document("\(newCoin.id)")
            .setData(data, merge: true) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
            }
    }
}
