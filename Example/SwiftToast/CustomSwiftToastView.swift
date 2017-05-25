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
    var duration: Double?
    var statusBarStyle: UIStatusBarStyle
    var aboveStatusBar: Bool
    var target: SwiftToastDelegate?
    var style: SwiftToastStyle
    
    // Customized
    var title: String
    var subtitle: String
    var backgroundColor: UIColor
}

class CustomSwiftToastView: UIView, SwiftToastViewProtocol {
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    var delegate: SwiftToastViewDelegate?
    
    var topConstraint: NSLayoutConstraint {
        get {
            return viewTopConstraint
        }
        set {
            viewTopConstraint = newValue
        }
    }
    
    var bottomConstraint: NSLayoutConstraint {
        get {
            return viewBottomConstraint
        }
        set {
            viewBottomConstraint = newValue
        }
    }
    
    func nib() -> SwiftToastViewProtocol? {
        return Bundle.main.loadNibNamed("CustomSwiftToastView", owner: self, options: nil)?.first as? CustomSwiftToastView
    }
    
    func configure(with toast: SwiftToastProtocol) {
        if let customToast = toast as? CustomSwiftToast {
            titleLabel.text = customToast.title
            subtitleLabel.text = customToast.subtitle
            backgroundColor = customToast.backgroundColor
        }
    }
}
