//
//  ActivityStackView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class ActivityStackView: UIStackView, UIViewProtocol {
    
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
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 10
    }
    
    func set(numberOfSubStackViews: Int, numberOfButtons: Int, titles: [[String]], buttonColors: [[UIColor]]) {
        for i in 0..<numberOfSubStackViews {
            let stackView = SubStackView()
            stackView.set(numberOfButtons: numberOfButtons, with: titles[i], with: buttonColors[i])
            self.addArrangedSubview(stackView)
        }
        
        configureView()
    }
}
