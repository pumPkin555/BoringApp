//
//  UIColor+ext.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 25.09.2021.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        if (hex.contains("#")) {
            let newHex = hex.replacingOccurrences(of: "#", with: "")
            let scanner = Scanner(string: newHex)
            var alpha: CGFloat = 1.0
            var hexInt64: UInt64 = 0
            if (newHex.count == 6) {
                if (scanner.scanHexInt64(&hexInt64)) {
                    let red = CGFloat((hexInt64 & 0xFF0000) >> 16) / CGFloat(255.0)
                    let green = CGFloat((hexInt64 & 0x00FF00) >> 8) / CGFloat(255.0)
                    let blue = CGFloat(hexInt64 & 0x0000FF) / CGFloat(255.0)
                    
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            } else if (newHex.count == 8) {
                if (scanner.scanHexInt64(&hexInt64)) {
                    let red = CGFloat((hexInt64 & 0xFF000000) >> 24) / CGFloat(255.0)
                    let green = CGFloat((hexInt64 & 0x00FF0000) >> 16) / CGFloat(255.0)
                    let blue = CGFloat((hexInt64 & 0x0000FF00) >> 8) / CGFloat(255.0)
                    alpha = CGFloat(hexInt64 & 0x000000FF) / CGFloat(255.0)
                    
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            } else {
                return nil
            }
        }
        return nil
    }
}

