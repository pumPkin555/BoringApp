//
//  BookMark.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

class BoringButton: UIButton {
    
    var link: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureBookMark(with: UIImage(systemName: "bookmark") ?? UIImage(), tintColor: UIColor.white)
    }
    
//    init(image: UIImage, tintColor: UIColor) {
//        super.init(frame: .zero)
//        configureBookMark(with: image, tintColor: tintColor)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, tintColor: UIColor, link: String?) {
        self.link = link
        configureBookMark(with: image, tintColor: tintColor)
    }
    
    private func configureBookMark(with image: UIImage, tintColor: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(image, for: .normal)
        self.backgroundColor = UIColor.clear
        self.tintColor = tintColor
        
        self.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func linkButtonTapped() {
        NotificationCenter.default.post(name: .link, object: self.link)
    }
}
