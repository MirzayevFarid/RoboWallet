//
//  HapticManager.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 17.11.2021.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }

}
