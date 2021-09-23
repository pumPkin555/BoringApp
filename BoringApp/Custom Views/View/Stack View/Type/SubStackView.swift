//
//  SubStackView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class SubStackView: UIStackView, UIViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.axis = .horizontal
        self.distribution = .fillProportionally
        self.spacing = 10
    }
    
    func set(numberOfButtons: Int, with titles: [String], with colors: [UIColor]) {
        for i in 0..<numberOfButtons {
            let button = ActivityButton(title: titles[i], backgroundColor: colors[i])
            self.addArrangedSubview(button)
        }
        
        configureView()
    }
}
