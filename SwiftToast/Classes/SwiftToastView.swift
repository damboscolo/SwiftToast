//
//  SwiftToast.swift
//  Daniele Boscolo
//
//  Created by damboscolo on 04/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

public protocol SwiftToastViewProtocol: class {
    var delegate: SwiftToastViewDelegate? {get set}
    var topConstraint: NSLayoutConstraint {get set}
    var bottomConstraint: NSLayoutConstraint {get set}
    
    func nib() -> SwiftToastViewProtocol?
    func configure(with toast: SwiftToastProtocol)
}

public protocol SwiftToastViewDelegate {
    func swiftToastViewDidTouchUpInside(_ swiftToastView: SwiftToastViewProtocol)
}

class SwiftToastView: UIView, SwiftToastViewProtocol {
    
    var delegate: SwiftToastViewDelegate?

    // MARK:- Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    // MARK:- NSLayoutConstraints
    
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
    
    // MARK:- Initializers
    
    func nib() -> SwiftToastViewProtocol? {
        return Constants.bundle?.loadNibNamed("SwiftToastView", owner: self, options: nil)?.first as? SwiftToastView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toastViewButtonTouchUpInside(_:))))
    }
    
    // MARK:- Configure
    
    func configure(with toast: SwiftToastProtocol) {
        guard let toast = toast as? SwiftToast else {
            return
        }
        titleLabel.text = toast.text
        titleLabel.textAlignment = toast.textAlignment
        titleLabel.font = toast.font
        backgroundColor = toast.backgroundColor
        isUserInteractionEnabled = toast.isUserInteractionEnabled
        
        if let image = toast.image {
            imageView.image = image
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
    }
    
    // MARK:- Actions
    
    @objc private func toastViewButtonTouchUpInside(_ sender: UIGestureRecognizer) {
        delegate?.swiftToastViewDidTouchUpInside(self)
    }
}
