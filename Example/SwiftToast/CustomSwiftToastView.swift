//
//  CustomSwiftToastView.swift
//  SwiftToast
//
//  Created by Daniele Boscolo on 24/05/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SwiftToast

struct CustomSwiftToast: SwiftToastProtocol {
    // Protocoled
    var duration: Double?
    var minimumHeight: CGFloat?
    var aboveStatusBar: Bool
    var statusBarStyle: UIStatusBarStyle
    var isUserInteractionEnabled: Bool
    var target: SwiftToastDelegate?
    var style: SwiftToastStyle
    
    // Customized
    var title: String
    var subtitle: String
    var backgroundColor: UIColor
}

class CustomSwiftToastView: UIView, SwiftToastViewProtocol {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var topConstraint: NSLayoutConstraint!

    func nib() -> SwiftToastViewProtocol? {
        return Bundle.main.loadNibNamed("CustomSwiftToastView", owner: self, options: nil)?.first as? CustomSwiftToastView
    }
    
    func configure(with toast: SwiftToastProtocol) {
        guard let customToast = toast as? CustomSwiftToast else { return }
            
        // put your configure code here

        titleLabel.text = customToast.title
        subtitleLabel.text = customToast.subtitle
        backgroundColor = customToast.backgroundColor

        // Compensate iPhone X-like top notch
        guard #available(iOS 11.0, tvOS 11.0, *) else { return }
        topConstraint.constant = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
    }
}
