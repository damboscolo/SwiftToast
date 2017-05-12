//
//  Constant.swift
//  Pods
//
//  Created by Daniele Boscolo on 11/05/17.
//  Copyright © 2017 Daniele Boscolo. All rights reserved.
//

import Foundation

struct Constants {
    static var bundle: Bundle? {
        let podBundle = Bundle(for: SwiftToastView.self)
        if let bundleURL = podBundle.url(forResource: "SwiftToast", withExtension: "bundle") {
            return Bundle(url: bundleURL)
        }
        return nil
    }
}
