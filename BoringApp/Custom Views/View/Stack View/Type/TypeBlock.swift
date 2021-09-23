//
//  TypeBlock.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class TypeBlock: UIStackView, UIViewProtocol {
    
    let label: UILabel = UILabel()
    let activityStackView: ActivityStackView = ActivityStackView()
    let line: UIView = UIView()
    
    let titles: [[String]] = [
        ["education", "recreational", "social"],
        ["diy", "charity", "cooking"],
        ["relaxation", "music", "busywork"]
    ]
    
    let buttonColors: [[UIColor]] = [
        [UIColor.systemBlue, UIColor.systemYellow, UIColor.systemRed],
        [UIColor.systemPink, UIColor.systemTeal, UIColor.systemGreen],
        [UIColor.systemOrange, UIColor.systemIndigo, UIColor.systemPurple]
    ]
    
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
        self.distribution = .fillProportionally
        self.spacing = 5
        
        
        configureLabel()
        configureStackView()
        configureLineView()
        
        let views = [label, activityStackView, line]
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    private func configureLabel() {
        label.text = "TYPE"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStackView() {
        activityStackView.set(numberOfSubStackViews: 3, numberOfButtons: 3, titles: titles, buttonColors: buttonColors)
    }
    
    private func configureLineView() {
        line.translatesAutoresizingMaskIntoConstraints = false
        line.frame.size.height = 2
        line.backgroundColor = UIColor.black
    }
}
