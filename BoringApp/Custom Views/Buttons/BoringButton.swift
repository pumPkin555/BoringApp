//
//  BookMark.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

class BoringButton: UIButton {
    
    private var link: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, tintColor: UIColor, link: String?) {
        self.link = link
        configureBookMark(with: image, tintColor: tintColor)
    }
    
    func hide(_ flag: Bool) {
        self.isHidden = flag
    }
    
    func getLink() -> String? {
        guard let link = self.link else { return nil }
        return link
    }
    
    private func configureBookMark(with image: UIImage, tintColor: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(image, for: .normal)
        self.backgroundColor = UIColor.clear
        self.tintColor = tintColor
        self.isHidden = false
    }
}
