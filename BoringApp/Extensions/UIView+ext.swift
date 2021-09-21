//
//  UIView+ext.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

extension UIView {
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
