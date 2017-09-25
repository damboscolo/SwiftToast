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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func nib() -> SwiftToastViewProtocol? {
        return Bundle.main.loadNibNamed("CustomSwiftToastView", owner: self, options: nil)?.first as? CustomSwiftToastView
    }
    
    func configure(with toast: SwiftToastProtocol) {
        if let customToast = toast as? CustomSwiftToast {
            
            // put your configure code here
            
            titleLabel.text = customToast.title
            subtitleLabel.text = customToast.subtitle
            backgroundColor = customToast.backgroundColor
        }
    }
}
