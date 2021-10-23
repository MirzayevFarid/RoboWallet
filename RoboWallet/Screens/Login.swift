//
//  Login.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 22.10.2021.
//

// @TODO: Change offset on keyboard opened

import SwiftUI
import NavigationKit

struct Login: View {
    @State var userName = ""
    @State var password = ""

    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            ZStack {
                Color("mainPurple")
                    .ignoresSafeArea()

                // ICONS
                Image("btc3")
                    .position(x: 60, y: 80)
                    .ignoresSafeArea()

                Image("eth3")
                    .position(x: UIScreen.screenWidth / 1.15, y: UIScreen.screenHeight / 7)
                    .ignoresSafeArea()

                Image("mountain3")
                    .position(x: 50, y: 280)
                    .ignoresSafeArea()

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


                        NavigationStep(type: .fullScreenSheet, style: .view) {
                            SignUp()
                         } label: {
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
                            .padding(.bottom, 30)

                        Spacer(minLength: 80)


                    }
                    .padding(25)
                    .background(BlurredBackground())
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    .padding(.top, 300)
                    .ignoresSafeArea()
                }

                Image("robotLogin")
                    .position(x: (UIScreen.screenWidth / 2) - 15, y: 250)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
        .navigationBarHidden(true)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().previewDevice(PreviewDevice(rawValue: "iPhone 8")).preferredColorScheme(.dark)
        Login().previewDevice(PreviewDevice(rawValue: "iPhone 11")).preferredColorScheme(.dark)
        Login().previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max")).preferredColorScheme(.dark)

    }
}
