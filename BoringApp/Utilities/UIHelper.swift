//
//  UIHelper.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 10.10.2021.
//

import UIKit

class UIHelper {
    static func configureThreeFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let padding: CGFloat = 12
        let spacing: CGFloat = 5
        let width: CGFloat = view.bounds.width
        
        let availableWidth: CGFloat = width - (padding * 2) - (spacing * 2)
        
        let itemWidth = availableWidth / 3.1
        let itemHeight = itemWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
}
