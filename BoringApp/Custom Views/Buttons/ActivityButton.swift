//
//  ActivityButton.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class ActivityButton: UIButton, UIViewProtocol {
    
    private var color: UIColor = UIColor.clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.color = color
        self.backgroundColor = color

        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        round(corners: [.topLeft, .bottomRight], radius: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.label, for: .normal)
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        if (LonelyManager.shared.currentArray.count < 1) {
            LonelyManager.shared.addType(with: self.titleLabel?.text ?? "")
            self.backgroundColor = UIColor.systemGray2
            NotificationCenter.default.post(name: .typeName, object: Types(rawValue: self.titleLabel?.text ?? ""))
        } else {
            LonelyManager.shared.delete(with: self.titleLabel?.text ?? "")
            self.backgroundColor = color
        }
    }
}
