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
public enum SwiftToastStyle {
    case navigationBar
    case statusBar
}
public class SwiftToast {
    var text: String
    var textAlignment: NSTextAlignment
    var image: UIImage?
    var backgroundColor: UIColor
    var textColor: UIColor
    var font: UIFont
    var duration: Double?
    var statusBarStyle: UIStatusBarStyle
    var aboveStatusBar: Bool
    var delegate: SwiftToastDelegate?
    var style: SwiftToastStyle
    
    public init(text: String? = "",
                textAlignment: NSTextAlignment? = .center,
                image: UIImage? = nil,
                backgroundColor: UIColor? = .red,
                textColor: UIColor? = .white,
                font: UIFont? = .systemFont(ofSize: 14.0),
                duration: Double? = 2.0,
                statusBarStyle: UIStatusBarStyle? = .lightContent,
                aboveStatusBar: Bool? = false,
                target: SwiftToastDelegate? = nil,
                style: SwiftToastStyle? = .navigationBar)
    {
        self.text = text!
        self.textAlignment = textAlignment!
        self.image = image
        self.backgroundColor = backgroundColor!
        self.textColor = textColor!
        self.font = font!
        self.duration = duration
        self.statusBarStyle = statusBarStyle!
        self.aboveStatusBar = aboveStatusBar!
        self.delegate = target
        self.style = style!
    }
}

public class SwiftToastController {
    // MARK:- Defaults values
//    
//    var text: String = ""
//    var textAlignment: NSTextAlignment = .center
//    var image: UIImage? = nil
//    var backgroundColor: UIColor = .red
//    var textColor: UIColor = .white
//    var font: UIFont = .systemFont(ofSize: 14.0)
//    var duration: Double? = 2.0
//    var statusBarStyle: UIStatusBarStyle = .lightContent
//    var aboveStatusBar: Bool = false
//    var target: SwiftToastDelegate? = nil
//    var style: SwiftToastStyle = .navigationBar

    
    public static var shared = SwiftToastController()
    
    var delegate: SwiftToastDelegate?
    
    private var toastView: SwiftToastView? = SwiftToastView.nib()
    private var toastViewHeightConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var hideTimer: Timer = Timer()
    var currentToast: SwiftToast = SwiftToast()
    
    private init() {
        self.setup()
    }
    
    // MARK:- Setup
    
    private func setup() {
        if let keyWindow = UIApplication.shared.keyWindow {
            guard let toastView = toastView else {
                return
            }
            toastView.delegate = self
            keyWindow.addSubview(toastView)
            
            // Set constraints
            toastView.translatesAutoresizingMaskIntoConstraints = false
            topConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: keyWindow, attribute: .top, multiplier: 1, constant: -toastView.frame.size.height)
            let leadingConstraint = NSLayoutConstraint(item: toastView, attribute: .leading, relatedBy: .equal, toItem: keyWindow, attribute: .leading, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: toastView, attribute: .trailing, relatedBy: .equal, toItem: keyWindow, attribute: .trailing, multiplier: 1, constant: 0)
            configureToastStyle()
            keyWindow.addConstraints([topConstraint!, leadingConstraint, trailingConstraint, toastViewHeightConstraint!])
        }
    }
    
    func configureToastStyle() {
        // Revove current constraint
        if let toastViewHeightConstraint = toastViewHeightConstraint, let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.removeConstraint(toastViewHeightConstraint)
        }
        
        switch currentToast.style {
        case .navigationBar:
            toastView?.viewTopConstraint.constant = 25.0
            toastView?.viewBottomConstraint.constant = 16.0
            toastViewHeightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64.0)
        case .statusBar:
            toastView?.viewTopConstraint.constant = 0.0
            toastView?.viewBottomConstraint.constant = 0.0
            toastViewHeightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20.0)
        }
        
        // Add new constraint
        if let toastViewHeightConstraint = toastViewHeightConstraint, let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addConstraint(toastViewHeightConstraint)
        }
    }
    
    func configureStatusBar(hide: Bool) {
        if hide {
            if currentToast.style == .statusBar || currentToast.aboveStatusBar {
                UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar + 1
            } else {
                UIApplication.shared.statusBarStyle = statusBarStyle
            }
        } else {
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
            UIApplication.shared.statusBarStyle = applicationStatusBarStyle
        }
    }
    
    // MARK:- Customizations

    // status bar
    var applicationStatusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    // MARK:- Public functions
    
    public func present(_ toast: SwiftToast) {
        guard let toastView = toastView else {
            return
        }

        dismiss {
            // after dismiss if needed, setup toast
            self.currentToast = toast
            self.configureToastStyle()
            self.statusBarStyle = toast.statusBarStyle
            self.delegate = toast.delegate
            
            toastView.configure(with: toast.text,
                                textColor: toast.textColor,
                                font: toast.font,
                                textAlignment: toast.textAlignment,
                                image: toast.image,
                                color: toast.backgroundColor
            )
            UIApplication.shared.keyWindow?.layoutIfNeeded()

            // present
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.topConstraint?.constant = 0.0
                self.configureStatusBar(hide: true)
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
        guard let toastView = toastView else {
            return
        }
        hideTimer.invalidate()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = -toastView.frame.size.height
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }, completion: { (_ finished) in
            if finished {
                self.configureStatusBar(hide: false)
                completion?()
            }
        })
    }
}

extension SwiftToastController: SwiftToastViewDelegate {
    func swiftToastViewDidTouchUpInside(_ swiftToastView: SwiftToastView) {
        dismiss(completion: nil)
        delegate?.swiftToastDidTouchUpInside(currentToast)
    }
}
