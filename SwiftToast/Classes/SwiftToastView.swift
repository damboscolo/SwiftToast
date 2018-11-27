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
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet private var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var viewMinimumHeightConstraint: NSLayoutConstraint!
    
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

        // For iPhone X-like
        var compensateNotch = false
        var statusBarHeight: CGFloat = 20.0
        var bottomSafeArea: CGFloat = 0.0
        if #available(iOS 11.0, tvOS 11.0, *) {
            statusBarHeight = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0
            bottomSafeArea = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
            compensateNotch = statusBarHeight > 20
        }
        
        switch toast.style {
        case .statusBar:
            viewTopConstraint.constant = compensateNotch ? 32.0 : 2.0
            viewBottomConstraint.constant = 2.0
        case .belowNavigationBar:
            viewTopConstraint.constant = 2.0
            viewBottomConstraint.constant = 2.0
        case .bottomToTop:
            viewTopConstraint.constant = 25.0
            viewBottomConstraint.constant = bottomSafeArea + 16.0
        case.navigationBar:
            viewTopConstraint.constant = statusBarHeight + 5
            viewBottomConstraint.constant = 16.0
        }
    }
}
