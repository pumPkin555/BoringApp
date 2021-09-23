//
//  ParticipantsStackView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class ParticipantsBlock: UIStackView, UIViewProtocol {
    
    let label: UILabel = UILabel()
    let textField: UITextField = UITextField()
    
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
        configureTextField()
        
        let views: [UIView] = [label, textField]
        
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    private func configureLabel() {
        label.text = "PARTICIPANTS"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.white
        textField.font = UIFont(name: "Helvetica", size: 14)
        textField.placeholder = "Type the number of participants in your activity"
    }
    
}
