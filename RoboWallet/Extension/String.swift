//
//  String.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 17.11.2021.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
