//
//  SignUp.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

// @TODO: Change offset on keyboard opened

import SwiftUI

struct SignUp: View {
    @State var userName = ""
    @State var password = ""
    @State var email = ""
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                Image("robotSignUp")
                    .padding(.top, 20)

                // REGISTER FIELD
                VStack{
                    Text("Register")
                        .font(Font.system(size: 32, weight: .bold))
                        .padding(.bottom, 0)
                    VStack(spacing:20) {
                        CustomInput(text: $userName, icon: "person", color: "yellow", placeHolder: "Username")
                            .padding(20)
                            .background(Color("card"))
                            .cornerRadius(25)

                        CustomInput(text: $email, icon: "envelope", color: "green", placeHolder: "Email")
                            .padding(20)
                            .background(Color("card"))
                            .cornerRadius(25)

                        CustomInput(text: $password, icon: "lock", color: "purple",isSecure: true, placeHolder: "Password")
                            .padding(20)
                            .background(Color("card"))
                            .cornerRadius(25)
                    }
                    PrimaryButton(text: "Register") {

                    }
                    Spacer()
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                        .padding(5)

                    NavigationDismissStep(style: .button, presentationMode: presentationMode, label: {
                        Text("Login")
                            .foregroundColor(Color("purple2"))
                    })

                    Spacer(minLength: 80)
                }
            }
            .padding()
            .background(BlurredBackground())
            .ignoresSafeArea()
        }.ignoresSafeArea()
    }

}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp().previewDevice(PreviewDevice(rawValue: "iPhone 8")).preferredColorScheme(.dark)
        SignUp().previewDevice(PreviewDevice(rawValue: "iPhone 11")).preferredColorScheme(.dark)
        SignUp().previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max")).preferredColorScheme(.dark)
    }
}
