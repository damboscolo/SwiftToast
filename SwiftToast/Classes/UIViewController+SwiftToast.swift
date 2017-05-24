//
//  UIViewController+SwiftToast.swift
//  Pods
//
//  Created by Daniele Boscolo on 22/05/17.
//
//

import UIKit

public extension UIViewController {
    public func present(_ toast: SwiftToast, animated: Bool) {
        SwiftToastController.shared.present(toast, animated: animated)
    }
    
    public func dismissSwiftToast(_ animated: Bool) {
        SwiftToastController.shared.dismiss(animated)
    }
}

