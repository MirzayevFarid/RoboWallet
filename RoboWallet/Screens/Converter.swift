//
//  Converter.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 2.11.2021.
//

import SwiftUI

struct Converter: View {
    @State private var val1 = "0"
    @State private var val2 = "0"
    @State private var selection = 1
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {

        ZStack {

            Background()

            VStack(alignment: .leading) {
                HStack(spacing: UIScreen.screenWidth / 3.5) {


                    NavigationDismissStep(style: .button, presentationMode: presentationMode, label: {
                        Image(systemName: "arrow.backward")
                            .font(Font.body.weight(.bold))
                            .foregroundColor(Color.white)                        .background(
                                Circle()
                                    .fill(Color("card"))
                                    .frame(width: 50, height: 50)
                            )
                    })
                    .padding(.leading)

                    Text("Converter")
                }
                .padding(.leading)
                .padding(.top, 50)

                CoinsView(val1: $val1, val2: $val2, selection: $selection)

                Spacer()

                KeyPad(string: selection == 1 ? $val1 : $val2)
                    .font(.largeTitle)

            }.ignoresSafeArea()

        }
        .onTapGesture {
            hideKeyboard()
        }
        .ignoresSafeArea()
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct Converter_Previews: PreviewProvider {
    static var previews: some View {
        Converter()
            .preferredColorScheme(.dark)
    }
}



struct KeyPadButton: View {
    var key: String

    var body: some View {
        Button(action: { self.action(self.key) }) {
            Text(key)
                .foregroundColor(Color.white)
                .frame(width: 120, height: 90)
        }
    }

    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }

    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

struct KeyPadRow: View {
    var keys: [String]

    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}


struct KeyPad: View {
    @Binding var string: String

    var body: some View {
        VStack {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: [".", "0", "⌫"])
        }
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
        .padding()
        .padding(.bottom)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color("card"))
        .cornerRadius(40, corners: [.topLeft, .topRight])
    }

    private func keyWasPressed(_ key: String) {
        switch key {
        case "." where string.contains("."): break
        case "." where string == "0": string += key
        case "⌫":
            string.removeLast()
            if string.isEmpty { string = "0" }
        case _ where string == "0": string = key
        default: string += key
        }
    }
}

struct Background: View {
    var body: some View {
        Group {
            Color("yellow")

            Image("layer")
                .position(x: UIScreen.screenWidth / 1.2, y: UIScreen.screenHeight / 6)
                .ignoresSafeArea()

            Image("ethStack")
                .position(x: UIScreen.screenWidth / 3, y: UIScreen.screenHeight / 2)
                .ignoresSafeArea()
        }
    }
}

struct CoinsView: View {

    @Binding var val1: String
    @Binding var val2: String
    @Binding var selection: Int

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "bitcoinsign.circle")
                    .font(Font.system(size: 30))
                    .font(Font.body.weight(.bold))
                    .foregroundColor(Color("yellow"))
                    .background(
                        Circle()
                            .fill(Color("yellow").opacity(0.2))
                            .frame(width: 60, height: 60)
                    )
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 10)

                VStack(alignment: .leading, spacing: 10) {
                    Text("BTC")
                        .font(Font.body.weight(.bold))
                    Text("Bitcoin")
                        .font(Font.body.weight(.bold)).foregroundColor(.gray)
                }

                Spacer()

                TextField(
                    val1,
                    text: $val1
                )
                    .onTapGesture {
                        hideKeyboard()
                        selection = 1
                    }
                .multilineTextAlignment(.center)
                .frame(minWidth: 80, idealWidth: CGRect.zero.width)
                .fixedSize(horizontal: true, vertical: false)

            }
            .padding(20)

            Divider()

            HStack(alignment: .center) {
                Image(systemName: "bitcoinsign.circle")
                    .font(Font.system(size: 30))
                    .font(Font.body.weight(.bold))
                    .foregroundColor(Color("yellow"))
                    .background(
                        Circle()
                            .fill(Color("yellow").opacity(0.2))
                            .frame(width: 60, height: 60)
                    )
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 10)

                VStack(alignment: .leading, spacing: 10) {
                    Text("BTC")
                        .font(Font.body.weight(.bold))
                    Text("Bitcoin")
                        .font(Font.body.weight(.bold)).foregroundColor(.gray)
                }

                Spacer()
                TextField(
                    val2,
                    text: $val2
                ).onTapGesture {
                    hideKeyboard()

                    selection = 2
                }

                    .multilineTextAlignment(.center)
                    .frame(minWidth: 80, idealWidth: CGRect.zero.width)
                    .fixedSize(horizontal: true, vertical: false)

            }
            .padding(20)
        }
        .background(Color("card"))
        .cornerRadius(25)
        .padding()
        .padding(.top, 50)
    }

}
