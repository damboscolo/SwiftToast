//
//  SwiftToast.swift
//  SwiftToast
//
//  Created by Daniele Boscolo on 05/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

public protocol SwiftToastDelegate {
    func swiftToastDidTouchUpInside(_ swiftToast: SwiftToast)
}

public class SwiftToastConfig {
    var text: String? = nil
    var image: UIImage? = nil
    var backgroundColor: UIColor? = nil
    var textColor: UIColor? = nil
    var font: UIFont? = nil
    var duration: Double? = nil
    var statusBarStyle: UIStatusBarStyle? = nil
    var delegate: SwiftToastDelegate? = nil
    
    public init() {}
    
    public init(text: String?, image: UIImage?, backgroundColor: UIColor?, textColor: UIColor?, font: UIFont?, duration: Double?, statusBarStyle: UIStatusBarStyle?, delegate: SwiftToastDelegate?) {
        self.text = text
        self.image = image
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.duration = duration
        self.statusBarStyle = statusBarStyle
        self.delegate = delegate
    }
}

public class SwiftToast {
    
    public static var shared = SwiftToast()
    
    var delegate: SwiftToastDelegate?
    
    private var toastView = SwiftToastView.nib()
    private var topConstraint: NSLayoutConstraint?
    private var hideTimer = Timer()
    
    private init() {
        self.setup()
    }
    
    // MARK:- Setup
    
    private func setup() {
        if let keyWindow = UIApplication.shared.keyWindow {
            // Set toastView delegate
            toastView.delegate = self
            
            keyWindow.addSubview(toastView)
            
            // Set constraints
            toastView.translatesAutoresizingMaskIntoConstraints = false
            topConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: keyWindow, attribute: .top, multiplier: 1, constant: -toastView.frame.size.height)
            let leadingConstraint = NSLayoutConstraint(item: toastView, attribute: .leading, relatedBy: .equal, toItem: keyWindow, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: toastView, attribute: .trailing, relatedBy: .equal, toItem: keyWindow, attribute: .trailing, multiplier: 1, constant: 0)
            let heightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64.0)
            keyWindow.addConstraints([topConstraint!, leadingConstraint, trailingConstraint, heightConstraint])
        }
    }
    
    // MARK:- Customizations
    
    var font: UIFont {
        get {
            return self.toastView.titleLabel.font
        } set {
            self.toastView.titleLabel.font = newValue
        }
    }
    
    var textColor: UIColor {
        get {
            return self.toastView.titleLabel.textColor
        } set {
            self.toastView.titleLabel.textColor = newValue
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return self.toastView.backgroundColor ?? UIColor.clear
        } set {
            self.toastView.backgroundColor = newValue
        }
    }
    
    // status bar
    var currentStatusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle
    var preferredStatusBarStyle: UIStatusBarStyle = .lightContent
    
    // MARK:- Public functions
    
    public func present(_ toast: SwiftToastConfig) {
        UIApplication.shared.keyWindow?.layoutIfNeeded()
        font = toast.font ?? font
        preferredStatusBarStyle = toast.statusBarStyle ?? preferredStatusBarStyle
        delegate = toast.delegate
        
        dismiss {
            // after dismiss if needed, setup toast
            self.toastView.configure(with: toast.text ?? "", image: toast.image, color: toast.backgroundColor ?? self.backgroundColor)
            UIApplication.shared.keyWindow?.layoutIfNeeded()
            
            // present
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.topConstraint?.constant = 0.0
                UIApplication.shared.statusBarStyle = self.preferredStatusBarStyle
                UIApplication.shared.keyWindow?.layoutIfNeeded()
            }, completion: { (_ finished) in
                if finished, let duration = toast.duration {
                    self.hideTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.hideTimerSelector(_:)), userInfo: nil, repeats: false)
                }
            })
        }
    }
    
    // MARK:- Animations
    
    @objc func hideTimerSelector(_ timer: Timer) {
        dismiss(completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        hideTimer.invalidate()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = -self.toastView.frame.size.height
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }, completion: { (_ finished) in
            if finished {
                UIApplication.shared.statusBarStyle = self.currentStatusBarStyle
                completion?()
            }
        })
    }
}

extension SwiftToast: SwiftToastViewDelegate {
    func swiftToastViewDidTouchUpInside(_ swiftToastView: SwiftToastView) {
        dismiss(completion: nil)
        delegate?.swiftToastDidTouchUpInside(self)
    }
}
