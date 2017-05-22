//
//  UIViewController+SwiftToast.swift
//  Pods
//
//  Created by Daniele Boscolo on 22/05/17.
//
//

import UIKit
import SwiftToast

public extension UIViewController {
    public func present(_ toast: SwiftToast) {
        SwiftToastController.shared.present(toast)
    }
    
    public func dismissSwiftToast() {
        SwiftToastController.shared.dismiss()
    }
}

