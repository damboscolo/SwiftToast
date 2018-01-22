//
//  UIViewController+SwiftToast.swift
//  Pods
//
//  Created by Daniele Boscolo on 22/05/17.
//
//

import UIKit

public extension UIViewController {
    public func present(_ toast: SwiftToastProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: SwiftToastView(), animated: animated)
    }
    
    public func present(_ toast: SwiftToastProtocol, withCustomSwiftToastView customToastView: SwiftToastViewProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: customToastView, animated: animated)
    }
    
    public func dismissSwiftToast(_ animated: Bool) {
        SwiftToastController.shared.dismiss(animated)
    }
}

public extension UINavigationBar {
    static let height: CGFloat = UIDevice.IS_IPHONE_X ? 88.0 : 64.0
}

public extension UIDevice {
    // iDevice detection code
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812
}
