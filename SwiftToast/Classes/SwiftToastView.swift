//
//  SwiftToast.swift
//  Daniele Boscolo
//
//  Created by damboscolo on 04/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

public protocol SwiftToastViewProtocol: class {
    func configure(with toast: SwiftToastProtocol)
}

class SwiftToastView: UIView, SwiftToastViewProtocol {
    
    // MARK:- Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
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
        if let view = bundle.loadNibNamed("SwiftToastView", owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            view.isUserInteractionEnabled = true
            addSubview(view)
        } else {
            assertionFailure("Could not load nib SwiftToastView")
        }
    }

    var bundle: Bundle {
        // framework bundle
        var bundle = Bundle(for: self.classForCoder)
        if let bundleURL = bundle.url(forResource: "SwiftToastView", withExtension: "bundle") {
            // bundle for CocoaPods integration
            if let podBundle = Bundle(url: bundleURL) {
                bundle = podBundle
            } else {
                assertionFailure("Could not load SwiftToastView bundle")
            }
        }
        // bundle found
        return bundle
    }
    
//    var bundle: Bundle? {
//        let podBundle = Bundle(for: SwiftToastView.self)
//        guard let bundleURL = podBundle.url(forResource: "SwiftToast", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) else {
//            return nil
//        }
//        return bundle
//    }
    
    // MARK:- Configure
    
    func configure(with toast: SwiftToastProtocol) {
        guard let toast = toast as? SwiftToast else {
            return
        }
        titleLabel.text = toast.text
        titleLabel.textAlignment = toast.textAlignment
        titleLabel.textColor = toast.textColor
        titleLabel.font = toast.font
        backgroundColor = toast.backgroundColor
        isUserInteractionEnabled = toast.isUserInteractionEnabled
        
        if let image = toast.image {
            imageView.image = image
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        
        switch toast.style {
        case .statusBar:
            viewTopConstraint.constant = 0.0
            viewBottomConstraint.constant = 0.0
        default:
            viewTopConstraint.constant = 25.0
            viewBottomConstraint.constant = 16.0
        }
    }
}
