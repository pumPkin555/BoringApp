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
    
    //MARK: - Configure button
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.label
        self.textAlignment = .center
        self.sizeToFit()
    }
    
    //MARK: - Set label text
    
    func set(text: String) {
        self.text = text
        if (text == "education") {
            self.backgroundColor = UIColor.systemBlue
        } else if (text == "recreational") {
            self.backgroundColor = UIColor.systemGreen
        } else if (text == "social") {
            self.backgroundColor = UIColor.systemOrange
        } else if (text == "diy") {
            self.backgroundColor = UIColor.white
        } else if (text == "charity") {
            self.backgroundColor = UIColor.systemRed
        } else if (text == "cooking") {
            self.backgroundColor = UIColor.systemYellow
        } else if (text == "relaxation") {
            self.backgroundColor = UIColor.systemGreen
        } else if (text == "music") {
            self.backgroundColor = UIColor.systemPink
        } else if (text == "busywork") {
            self.backgroundColor = UIColor.systemGray2
        }
    }
}

