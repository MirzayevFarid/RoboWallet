//
//  SignUp.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

import SwiftUI

struct SignUp: View {
    @State var userName = ""
    @State var password = ""
    @State var email = ""

    var body: some View {
        VStack {
            Image("robotSignUp")
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)

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
                PrimaryButton(text: "Register") {}
                Spacer()
                Text("Already have an account?")
                    .foregroundColor(.gray)
                    .padding(5)
                NavigationLink(destination: Login()){
                    Text("Login")
                        .foregroundColor(Color("purple2"))
                }
                Spacer(minLength: 50)
            }
        }
        .padding()
        .background(BlurredBackground())
        .ignoresSafeArea()
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp().preferredColorScheme(.dark)
    }
}
