//
//  PriceBlock.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 24.09.2021.
//

import UIKit

class PriceBlock: UIView, UIViewProtocol {
    
    let label: UILabel = UILabel()
    let switcher: UISwitch = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLabel()
        configureSwitcher()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
    }
    
    private func configureLabel() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PRICE"
        label.textAlignment = .left
        label.textColor = UIColor.secondaryLabel
    }
    
    private func configureSwitcher() {
        self.addSubview(switcher)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.tintColor = UIColor.systemGreen
        switcher.backgroundColor = UIColor.clear
        switcher.isOn = false
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            switcher.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: switcher.leadingAnchor),
        ])
    }
}
