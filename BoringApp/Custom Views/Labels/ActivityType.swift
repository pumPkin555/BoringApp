//
//  ActivityTypeLabel.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class ActivityType: UILabel, UIViewProtocol {
    
    private let typeDictionary: [String : UIColor] = [
        "education"    : UIColor.systemBlue,
        "recreational" : UIColor.systemGreen,
        "social"       : UIColor.systemOrange,
        "diy"          : UIColor.systemTeal,
        "charity"      : UIColor.systemRed,
        "cooking"      : UIColor.systemYellow,
        "relaxation"   : UIColor.systemPurple,
        "music"        : UIColor.systemPink,
        "busywork"     : UIColor.systemGray2
    ]

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
        self.backgroundColor = typeDictionary[text]
    }
}

