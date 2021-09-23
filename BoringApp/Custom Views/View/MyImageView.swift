//
//  RefreshImageView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

class MyImageView: UIImageView, UIViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    init(image: UIImage) {
        super.init(frame: .zero)
        
        self.image = image
        configureView()
    }
    
    func set(image: UIImage) {
        self.image = image
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
//        self.image = UIImage(systemName: SFSymbols.arrowClockwiseCircle.rawValue) ?? UIImage()
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.white
    }
}