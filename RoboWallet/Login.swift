//
//  Login.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

import SwiftUI

struct Login: View {
    @State var userName = ""
    @State var password = ""

    var body: some View {
        ZStack {
            Color("mainPurple")
                .ignoresSafeArea()


            // ICONS
            Image("btc3")
                .offset(x:-120, y: -320)
            Image("eth3")
                .offset(x:150, y: -290)
            Image("mountain3")
                .offset(x:-140, y: -165)


            // LOGIN FIELD
            ZStack {
                VStack{
                    Text("Login")
                        .font(Font.system(size: 32, weight: .bold))
                        .padding(30)

                    VStack(spacing:20) {
                        CustomInput(text: $userName, icon: "person", color: "yellow", placeHolder: "Username")

                        Divider()
                        CustomInput(text: $password, icon: "lock", color: "purple",isSecure: true, placeHolder: "Password")
                    }
                    .padding(25)
                    .background(Color("card"))
                    .cornerRadius(25)
                    HStack(spacing: 60) {
                        Text("Forget Password?")
                            .foregroundColor(Color("purple2"))
                        PrimaryButton(text: "Login") {
                        }
                    }
                    Spacer()
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                        .padding(5)
                    NavigationLink(destination: SignUp()){
                        Text("Register")
                            .foregroundColor(Color("purple2"))
                    }
                    Spacer()
                    // SOCIAL LOGINS
                    HStack(spacing: 30) {
                        Image("facebook")
                            .frame(width: 50, height: 50)
                        Image("google")
                            .frame(width: 50, height: 50)
                        Image("apple")
                            .frame(width: 50, height: 50)
                    }.padding()
                }
                .padding(25)
                .background(BlurredBackground())
                .cornerRadius(40)
                .padding(.top, 300)
                .ignoresSafeArea()
            }
            Image("robotLogin")
                .offset(x:-10, y: -200)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().preferredColorScheme(.dark)
    }
}
