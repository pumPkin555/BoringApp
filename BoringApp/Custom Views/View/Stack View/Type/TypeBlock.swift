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
    
    let titles: [[String]] = [
        ["education", "recreational", "social"],
        ["diy", "charity", "cooking"],
        ["relaxation", "music", "busywork"]
    ]
    
    let buttonColors: [[UIColor]] = [
        [UIColor(hex: "#FF512F")!, UIColor(hex: "#FDFC47")!, UIColor(hex: "#EC6F66")!],
        [UIColor(hex: "#1488CC")!, UIColor(hex: "#02AAB0")!, UIColor(hex: "#DA22FF")!],
        [UIColor(hex: "#fe8c00")!, UIColor(hex: "#ff0084")!, UIColor(hex: "#283048")!]
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure view
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        
        self.axis = .vertical
        self.distribution = .fillProportionally
        self.spacing = 10
        
        
        configureLabel()
        configureStackView()
        
        let views = [label, activityStackView]
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    private func configureLabel() {
        label.text = "TYPE"
        label.textColor = UIColor.secondaryLabel
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStackView() {
        activityStackView.set(numberOfSubStackViews: 3, numberOfButtons: 3, titles: titles, buttonColors: buttonColors)
    }
}
