//
//  BlurBackgroundView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 26/08/2023.
//

import SwiftUI

struct BlurBackgroundView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
