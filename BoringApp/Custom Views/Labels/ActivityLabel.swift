//
//  ActivityLabel.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

class ActivityLabel: UILabel, UIViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure button
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.textColor = .label
        self.numberOfLines = 0
        self.font = UIFont(name: "Helvetica", size: 40)
        self.textAlignment = .left
        self.sizeToFit()
    }
    
    //MARK: - Set button text
    
    func set(text: String) {
        self.text = text
        configureView()
    }
}
