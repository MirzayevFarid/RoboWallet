//
//  CustomScrollView.swift
//  RoboWallet
//
//  Created by Mirzayev Farid on 17.11.2021.
//

import SwiftUI

struct RefreshableScrollView<Content:View>: View {
    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.refreshAction = action
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                content()
                    .anchorPreference(key: OffsetPreferenceKey.self, value: .top) {
                        geometry[$0].y
                    }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if offset > threshold {
                    refreshAction()
                }
            }
        }
    }

    private var content: () -> Content
    private var refreshAction: () -> Void
    private let threshold:CGFloat = 50.0
}

fileprivate struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
