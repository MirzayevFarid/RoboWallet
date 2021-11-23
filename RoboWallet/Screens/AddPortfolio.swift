//
//  AddPortfolio.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 20.11.2021.
//

import SwiftUI
import SwiftUIGIF


struct AddPortfolio: View {

    @State var portfolioName: String = ""
    @State var portfolioColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    @Environment(\.presentationMode) private var presentationMode


    var body: some View {
        ZStack(alignment: .top){
            BlurredBackground().ignoresSafeArea()


            VStack{

                Text("Create New Portfolio")
                    .padding()

                BlankPortfolioCard(portfolioName: $portfolioName, portfolioColor: $portfolioColor)
                    .padding(.trailing)
                    .frame(height: 350)



                PrimaryButton(text: "Save") {
                    presentationMode.wrappedValue.dismiss()
                
                }.padding(.horizontal)



            }


        }
        .onTapGesture{
            hideKeyboard()
        }
    }
}

struct AddPortfolio_Previews: PreviewProvider {
    static var previews: some View {
        AddPortfolio()
            .preferredColorScheme(.dark)
    }
}
