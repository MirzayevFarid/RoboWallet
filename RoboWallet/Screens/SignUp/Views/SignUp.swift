//
//  SignUp.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

// @TODO: Change offset on keyboard opened

import SwiftUI

struct SignUp: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var userInfo: UserInfo

    @State var user: UserViewModel = UserViewModel()
    @State private var showError = false
    @State private var errorString = ""

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
                        CustomInput(text: self.$user.fullname, icon: "person", color: "yellow", placeHolder: "Username")
                            .padding(20)
                            .background(Color("card"))
                            .cornerRadius(25)

                        CustomInput(text: self.$user.email, icon: "envelope", color: "green", placeHolder: "Email")
                            .padding(20)
                            .background(Color("card"))
                            .cornerRadius(25)

                        CustomInput(text: self.$user.password, icon: "lock", color: "purple",isSecure: true, placeHolder: "Password")
                            .padding(20)
                            .background(Color("card"))
                            .cornerRadius(25)
                    }
                    PrimaryButton(text: "Register") {
                        FBAuth.createUser(withEmail: self.user.email,
                                          name: self.user.fullname,
                                          password: self.user.password) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Account creation successful")
                            }

                        }
                    }
                    .alert(isPresented: $showError) {
                        Alert(title: Text("Error creating accout"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
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
        SignUp().preferredColorScheme(.dark)
    }
}
