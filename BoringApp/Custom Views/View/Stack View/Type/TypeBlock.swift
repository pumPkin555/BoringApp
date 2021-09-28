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
    
    let buttonColors1: [[UIColor]] = [
        [UIColor(hex: "#FF512F")!, UIColor(hex: "#FDFC47")!, UIColor(hex: "#EC6F66")!],
        [UIColor(hex: "#1488CC")!, UIColor(hex: "#02AAB0")!, UIColor(hex: "#DA22FF")!],
        [UIColor(hex: "#fe8c00")!, UIColor(hex: "#ff0084")!, UIColor(hex: "#283048")!]
    ]
    
    let buttonColors2: [[UIColor]] = [
        [UIColor(hex: "#DD2476")!, UIColor(hex: "#24FE41")!, UIColor(hex: "#F3A183")!],
        [UIColor(hex: "#2B32B2")!, UIColor(hex: "#00CDAC")!, UIColor(hex: "#9733EE")!],
        [UIColor(hex: "#f83600")!, UIColor(hex: "#33001b")!, UIColor(hex: "#859398")!]
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
        activityStackView.set(numberOfSubStackViews: 3, numberOfButtons: 3, titles: titles, buttonColors1: buttonColors1, buttonColors2: buttonColors2)
    }
    
    private func configureLineView() {
        line.translatesAutoresizingMaskIntoConstraints = false
        line.frame.size.height = 2
        line.backgroundColor = UIColor.black
    }
}
