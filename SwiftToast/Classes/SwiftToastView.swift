//
//  SwiftToast.swift
//  Daniele Boscolo
//
//  Created by damboscolo on 04/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

public protocol SwiftToastViewProtocol: class {
    func nib() -> SwiftToastViewProtocol?
    func configure(with toast: SwiftToastProtocol)
}

class SwiftToastView: UIView, SwiftToastViewProtocol {
    
    // MARK:- Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMinimumHeightConstraint: NSLayoutConstraint!
    
    // MARK:- Initializers
    
    func nib() -> SwiftToastViewProtocol? {
        let podBundle = Bundle(for: SwiftToastView.self)
        guard let bundleURL = podBundle.url(forResource: "SwiftToast", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) else {
            return nil
        }
        return bundle.loadNibNamed("SwiftToastView", owner: self, options: nil)?.first as? SwiftToastView
    }
    
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
        
        // Setup minimum height if needed
        if let minimumHeight = toast.minimumHeight {
            viewMinimumHeightConstraint.constant = minimumHeight
        }
        
        if let image = toast.image {
            imageView.image = image
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        
        switch toast.style {
        case .statusBar, .belowNavigationBar:
            viewTopConstraint.constant = 2.0
            viewBottomConstraint.constant = 2.0
        default:
            viewTopConstraint.constant = 25.0
            viewBottomConstraint.constant = 16.0
        }
    }
}
