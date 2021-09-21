//
//  ActivityTypeLabel.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class ActivityTypeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        round(corners: [.bottomRight], radius: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMainView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.sizeToFit()
    }
}

