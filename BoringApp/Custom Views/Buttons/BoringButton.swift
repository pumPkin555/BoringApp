//
//  BookMark.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

class BoringButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBookMark()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) {
        self.setImage(image, for: .normal)
        configureBookMark()
    }
    
    private func configureBookMark() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.white
    }
}
