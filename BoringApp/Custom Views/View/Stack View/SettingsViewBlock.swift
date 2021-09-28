//
//  SettingsView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 24.09.2021.
//

import UIKit

class SettingsViewBlock: UIStackView, UIViewProtocol {
    
    let typeBlock: TypeBlock = TypeBlock()
    let participantsBlock: ParticipantsBlock = ParticipantsBlock()
    let priceBlock: PriceBlock = PriceBlock()

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
//        self.distribution = .fillEqually
//        self.spacing = 5
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        self.addGestureRecognizer(tap)
        
        let views: [UIView] = [typeBlock, participantsBlock, priceBlock]
        
        for view in views {
            self.addArrangedSubview(view)
        }

        self.setCustomSpacing(10, after: typeBlock)
        self.setCustomSpacing(10, after: participantsBlock)
        self.setCustomSpacing(self.frame.height / 3, after: priceBlock)
    }
}
