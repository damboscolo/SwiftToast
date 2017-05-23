//
//  SwiftToast.swift
//  Daniele Boscolo
//
//  Created by damboscolo on 04/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

protocol SwiftToastViewDelegate {
    func swiftToastViewDidTouchUpInside(_ swiftToastView: SwiftToastView)
}

class SwiftToastView: UIView {
    
    var delegate: SwiftToastViewDelegate?

    // MARK:- Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK:- NSLayoutConstraints
    
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    // MARK:- Initializers
    
    class func nib() -> SwiftToastView? {
        return Constants.bundle?.loadNibNamed("SwiftToastView", owner: self, options: nil)?.first as? SwiftToastView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toastViewButtonTouchUpInside(_:))))
    }
    
    // MARK:- Configuration
    
    func configure(with text: String, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment, image: UIImage?, color: UIColor, isUserInteractionEnabled: Bool) {
        titleLabel.text = text
        titleLabel.textAlignment = textAlignment
        titleLabel.font = font
        backgroundColor = color
        self.isUserInteractionEnabled = isUserInteractionEnabled

        if let image = image {
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
