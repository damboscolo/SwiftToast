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
    
    // MARK:- Initializers
    class func nib() -> SwiftToastView? {
        return Constants.bundle?.loadNibNamed("SwiftToastView", owner: self, options: nil)?.first as? SwiftToastView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toastViewButtonTouchUpInside(_:))))
    }
    
    // MARK:- Configuration
    func configure(with message: String, image: UIImage?, color: UIColor) {
        titleLabel.text = message
        imageView.image = image
        backgroundColor = color
    }
    
    // MARK:- Actions
    @objc private func toastViewButtonTouchUpInside(_ sender: UIGestureRecognizer) {
        delegate?.swiftToastViewDidTouchUpInside(self)
    }
}
