//
//  ActivityTypeLabel.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class ActivityType: UILabel, UIViewProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        round(corners: [.bottomRight], radius: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(text: String) {
        self.text = text
        self.backgroundColor = UIColor.systemRed
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.sizeToFit()
    }
}

