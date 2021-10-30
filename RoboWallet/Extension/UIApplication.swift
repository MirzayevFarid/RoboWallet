//
//  UIApplication.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 31.10.2021.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
