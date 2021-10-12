//
//  SettingsView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 24.09.2021.
//

import UIKit

class SettingsViewBlock: UIView, UIViewProtocol {
    
    let participantsBlock: ParticipantsBlock = ParticipantsBlock()
    let priceBlock: PriceBlock = PriceBlock()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure interface
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        
        self.addSubview(participantsBlock)
        self.addSubview(priceBlock)
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            participantsBlock.topAnchor.constraint(equalTo: self.topAnchor),
            participantsBlock.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            participantsBlock.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.98),
            participantsBlock.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceBlock.topAnchor.constraint(equalTo: participantsBlock.bottomAnchor),
            priceBlock.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            priceBlock.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.98),
            priceBlock.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
