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
    
    // MARK:- Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        if let view = Bundle.main.loadNibNamed("CustomSwiftToastView", owner: self)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            view.isUserInteractionEnabled = true
            addSubview(view)
            clipsToBounds = true
        } else {
            assertionFailure("Could not load nib CustomSwiftToastView. ")
        }
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
