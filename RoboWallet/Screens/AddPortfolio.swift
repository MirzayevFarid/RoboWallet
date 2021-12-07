//
//  AddPortfolio.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 20.11.2021.
//

import SwiftUI
import SwiftUIGIF


//struct AddPortfolio: View {
//
//    @EnvironmentObject private var fs: FirestoreManager
//
//    @State var portfolioName: String = ""
//    @State var portfolioColor: String = "2D7FC1"
//
//    @State var newPortfolio: PortfolioModel = PortfolioModel(portfolioName: "New Portfolio", portfolioColor: "2D7FC1")
//
//
//    @EnvironmentObject var userInfo: UserInfo
//
//    @Environment(\.presentationMode) private var presentationMode
//
//
//    var body: some View {
//        ZStack(alignment: .top){
//            BlurredBackground().ignoresSafeArea()
//
//            VStack{
//                Text("Create New Portfolio")
//                    .padding()
//
//                BlankPortfolioCard(portfolioName: $portfolioName, portfolioColor: $portfolioColor)
//                    .padding(.trailing)
//                    .frame(height: 350)
//
//                PrimaryButton(text: "Save") {
//                    presentationMode.wrappedValue.dismiss()
//
//                    portfolioName = portfolioName.isEmpty ? portfolioName : "New Portfolio"
//                    newPortfolio = PortfolioModel(portfolioName: portfolioName, portfolioColor: portfolioColor)
//
//                    FirestoreManager.addPortfolio(uid: userInfo.user.uid, newPortfolio: newPortfolio) { (result) in
//                        switch result {
//                        case .failure(let error):
//                            print("Error Occured While Adding New Portolio")
//                            print(error.localizedDescription)
//                        case .success( _):
//                            print("Added New Portfolio")
//                        }
//                    }
//                    fs.portfolios.append(newPortfolio)
//
//
//                }
//            }
//            .onTapGesture{
//                hideKeyboard()
//            }
//        }
//    }
//}

//struct AddPortfolio_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPortfolio()
//            .preferredColorScheme(.dark)
//    }
//}
