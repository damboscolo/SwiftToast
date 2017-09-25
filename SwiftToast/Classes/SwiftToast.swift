//
//  SwiftToast.swift
//  SwiftToast
//
//  Created by Daniele Boscolo on 05/04/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import UIKit

public protocol SwiftToastDelegate {
    func swiftToastDidTouchUpInside(_ swiftToast: SwiftToastProtocol)
    func swiftToast(_ swiftToast: SwiftToastProtocol, presentedWith height: CGFloat)
    func swiftToastDismissed(_ swiftToast: SwiftToastProtocol)
}

// Make SwiftToastDelegate as optional functions
public extension SwiftToastDelegate {
    func swiftToastDidTouchUpInside(_ swiftToast: SwiftToastProtocol) {}
    func swiftToast(_ swiftToast: SwiftToastProtocol, presentedWith height: CGFloat) {}
    func swiftToastDismissed(_ swiftToast: SwiftToastProtocol) {}
}

public enum SwiftToastStyle {
    case navigationBar
    case statusBar
    case bottomToTop
    case belowNavigationBar
}

public protocol SwiftToastProtocol {
    var duration: Double? {get set}
    var minimumHeight: CGFloat? {get set}
    var aboveStatusBar: Bool {get set}
    var statusBarStyle: UIStatusBarStyle {get set}
    var isUserInteractionEnabled: Bool {get set}
    var target: SwiftToastDelegate? {get set}
    var style: SwiftToastStyle {get set}
}

public class SwiftToast: SwiftToastProtocol {
    public var text: String
    public var textAlignment: NSTextAlignment
    public var image: UIImage?
    public var backgroundColor: UIColor
    public var textColor: UIColor
    public var font: UIFont
    public var duration: Double?
    public var minimumHeight: CGFloat?
    public var statusBarStyle: UIStatusBarStyle
    public var aboveStatusBar: Bool
    public var isUserInteractionEnabled: Bool
    public var target: SwiftToastDelegate?
    public var style: SwiftToastStyle

    public static var defaultValue = SwiftToast()
    
    init() {
        text = ""
        textAlignment = .center
        image = nil
        backgroundColor = .red
        textColor = .white
        font = .boldSystemFont(ofSize: 14.0)
        duration = 2.0
        minimumHeight = nil
        statusBarStyle = .lightContent
        aboveStatusBar = false
        isUserInteractionEnabled = true
        target = nil
        style = .navigationBar
    }
    
    public init(text: String? = nil,
                textAlignment: NSTextAlignment? = nil,
                image: UIImage? = nil,
                backgroundColor: UIColor? = nil,
                textColor: UIColor? = nil,
                font: UIFont? = nil,
                duration: Double? = 0.0,
                minimumHeight: CGFloat? = nil,
                statusBarStyle: UIStatusBarStyle? = nil,
                aboveStatusBar: Bool? = nil,
                isUserInteractionEnabled: Bool? = nil,
                target: SwiftToastDelegate? = nil,
                style: SwiftToastStyle? = nil)
    {
        self.text = text ?? SwiftToast.defaultValue.text
        self.textAlignment = textAlignment ?? SwiftToast.defaultValue.textAlignment
        self.image = image ?? SwiftToast.defaultValue.image
        self.backgroundColor = backgroundColor ?? SwiftToast.defaultValue.backgroundColor
        self.textColor = textColor ?? SwiftToast.defaultValue.textColor
        self.font = font ?? SwiftToast.defaultValue.font
        self.duration = duration == 0 ? SwiftToast.defaultValue.duration : duration
        self.minimumHeight = minimumHeight
        self.statusBarStyle = statusBarStyle ?? SwiftToast.defaultValue.statusBarStyle
        self.aboveStatusBar = aboveStatusBar ?? SwiftToast.defaultValue.aboveStatusBar
        self.isUserInteractionEnabled = isUserInteractionEnabled ?? SwiftToast.defaultValue.isUserInteractionEnabled
        self.target = target ?? SwiftToast.defaultValue.target
        self.style = style ?? SwiftToast.defaultValue.style
    }
}

open class SwiftToastController {
    
    // MARK:- Properties
    
    public static var shared = SwiftToastController()
    fileprivate var toastView: SwiftToastViewProtocol?
    fileprivate var toastViewHeightConstraint: NSLayoutConstraint?
    fileprivate var topConstraint: NSLayoutConstraint?
    fileprivate var hideTimer: Timer = Timer()
    fileprivate var currentToast: SwiftToastProtocol = SwiftToast()
    fileprivate var delegate: SwiftToastDelegate?
    
    var applicationStatusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle
    
    private init() {
        self.setupToastView(SwiftToastView())
    }
    
    // MARK:- Setup
    
    private func setupToastView(_ newToastView: SwiftToastViewProtocol) {
        if let oldToastView = toastView as? UIView {
            oldToastView.removeFromSuperview()
        }
        toastView = newToastView.nib()
        
        guard let keyWindow = UIApplication.shared.keyWindow, let toastView = toastView as? UIView else {
            return
        }
        keyWindow.addSubview(toastView)
        
        // Set constraints
        toastView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: toastView, attribute: .leading, relatedBy: .equal, toItem: keyWindow, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: toastView, attribute: .trailing, relatedBy: .equal, toItem: keyWindow, attribute: .trailing, multiplier: 1, constant: 0)
        
        switch currentToast.style {
        case .navigationBar:
            toastViewHeightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64.0)
            topConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: keyWindow, attribute: .top, multiplier: 1, constant: -toastView.frame.size.height)
            
        case .statusBar:
            toastViewHeightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20.0)
            topConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: keyWindow, attribute: .top, multiplier: 1, constant: -toastView.frame.size.height)
            
        case .bottomToTop:
            toastViewHeightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64.0)
            topConstraint = NSLayoutConstraint(item: toastView, attribute: .bottom, relatedBy: .equal, toItem: keyWindow, attribute: .bottom, multiplier: 1, constant: toastView.frame.size.height)
            
        case .belowNavigationBar:
            toastViewHeightConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0.0)
            topConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: keyWindow, attribute: .top, multiplier: 1, constant: 64.0)
        }
        
        keyWindow.addConstraints([topConstraint!, leadingConstraint, trailingConstraint, toastViewHeightConstraint!])
        UIApplication.shared.keyWindow?.layoutIfNeeded()
        
        // Add gesture
        if currentToast.isUserInteractionEnabled {
            toastView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toastViewButtonTouchUpInside(_:))))
        }
    }
    
    // MARK:- Actions
    
    @objc private func toastViewButtonTouchUpInside(_ sender: UIGestureRecognizer) {
        dismiss(true, completion: nil)
        delegate?.swiftToastDidTouchUpInside(currentToast)
    }
    
    // MARK:- Customizations
    
    func configureStatusBar(for presentingToast: Bool) {
        if presentingToast {
            switch currentToast.style {
            case .navigationBar:
                if currentToast.aboveStatusBar {
                    UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar + 1
                } else {
                    UIApplication.shared.statusBarStyle = currentToast.statusBarStyle
                }
                
            case .statusBar:
                UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar + 1
                
            case .bottomToTop:
                break
                
            case .belowNavigationBar:
                break
            }
            
        } else {
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
            UIApplication.shared.statusBarStyle = applicationStatusBarStyle
        }
    }
    
    func configureConstraint(for presentingToast: Bool) {
        guard let toastView = toastView as? UIView else {
            return
        }
        if presentingToast {
            if currentToast.style == .belowNavigationBar {
                self.toastViewHeightConstraint?.constant = 1000.0 // Dynamic height
            } else {
                self.topConstraint?.constant = 0.0
            }
        } else {
            switch currentToast.style {
            case .bottomToTop:
                self.topConstraint?.constant = toastView.frame.size.height
            case .belowNavigationBar:
                self.toastViewHeightConstraint?.constant = 0.0
            default:
                self.topConstraint?.constant = -toastView.frame.size.height
            }
        }
        UIApplication.shared.keyWindow?.layoutIfNeeded()
    }
    
    // MARK:- Public functions
    
    func present(_ toast: SwiftToastProtocol, swiftToastView: SwiftToastViewProtocol, animated: Bool) {
        
        dismiss(animated) {
            
            // after dismiss if needed, setup toast
            self.currentToast = toast
            self.setupToastView(swiftToastView)
            self.delegate = toast.target
            self.toastView?.configure(with: toast)
            
            UIApplication.shared.keyWindow?.layoutIfNeeded()
            
            // present
            UIView.animate(withDuration: animated ? 0.3 : 0.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.configureConstraint(for: true)
                self.configureStatusBar(for: true)
                if let toastView = self.toastView as? UIView {
                    self.delegate?.swiftToast(self.currentToast, presentedWith: toastView.frame.size.height)
                }
                
            }, completion: { (_ finished) in
                if finished, let duration = toast.duration {
                    self.hideTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.hideTimerSelector(_:)), userInfo: animated, repeats: false)
                }
            })
        }
    }
    
    // MARK:- Animations
    
    @objc func hideTimerSelector(_ timer: Timer) {
        let animated = (timer.userInfo as? Bool) ?? false
        dismiss(animated, completion: nil)
    }
    
    func dismiss(_ animated: Bool, completion: (() -> Void)? = nil) {
        guard let _ = toastView as? UIView else {
            completion?()
            return
        }
        
        hideTimer.invalidate()
        
        UIView.animate(withDuration: animated ? 0.3 : 0.0, delay: 0, options: .curveEaseOut, animations: {
            self.configureConstraint(for: false)
            self.delegate?.swiftToastDismissed(self.currentToast)
        }, completion: { (_ finished) in
            if finished {
                self.configureStatusBar(for: false)
                completion?()
            }
        })
    }
}
