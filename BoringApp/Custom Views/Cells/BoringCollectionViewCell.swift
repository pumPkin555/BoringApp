//
//  BoringCollectionViewCell.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 10.10.2021.
//

import UIKit

class BoringCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "BoringCollectionViewCell"
    
    let label: UILabel = UILabel()
    
    private var isChosen: Bool = false
    private var labelText: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
        round(corners: [.topLeft, .bottomRight], radius: 20)
    }
    
    
    func configureLabel() {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.label
        label.textAlignment = NSTextAlignment.center
    }
    
    func set(color: UIColor, text: String) {
        self.backgroundColor = color
        self.labelText = text
        self.label.text = text
    }
    
    func select() {
        _ = UIColor.label
        if (self.isChosen) {
            underLineText(false)
            self.isChosen = false
        } else {
            underLineText(true)
            self.isChosen = true
        }
    }
    
    func chosen() -> Bool {
        return self.isChosen
    }
    
    private func underLineText(_ flag: Bool) {
        switch flag {
        case true:
            let textRange = NSRange(location: 0, length: labelText.count)
            let attributedText = NSMutableAttributedString(string: labelText)
            
            attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
            self.label.attributedText = attributedText
            
        case false:
            self.label.attributedText = nil
            self.label.text = labelText
        }
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
    }
}
