//
//  SubStackView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class SubStackView: UIStackView, UIViewProtocol {
    
    let educationButton: ActivityButton = ActivityButton()
    let recreationalButton: ActivityButton = ActivityButton()
    let socialButton: ActivityButton = ActivityButton()
    let diyButton: ActivityButton = ActivityButton()
    let charityButton: ActivityButton = ActivityButton()
    let cookingButton: ActivityButton = ActivityButton()
    let relaxationButton: ActivityButton = ActivityButton()
    let musicButton: ActivityButton = ActivityButton()
    let busyworkButton: ActivityButton = ActivityButton()
    
//    var array: [ActivityButton] = []
//    var array2: [ActivityButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        array = [educationButton, recreationalButton, recreationalButton, socialButton, diyButton, charityButton, cookingButton, relaxationButton, musicButton, busyworkButton]
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
    
    func set(numberOfButtons: Int, with titles: [String], with colors1: [UIColor], colors2: [UIColor]) {
        for i in 0..<numberOfButtons {
            let button = ActivityButton(title: titles[i], color1: colors1[i].cgColor, color2: colors2[i].cgColor)
            self.addArrangedSubview(button)
        }
        
        configureView()
    }
}
