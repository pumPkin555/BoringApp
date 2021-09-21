//
//  ActivityButton.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class CardView: UIView {
    
    let activityTypeLabel: ActivityTypeLabel = ActivityTypeLabel()
    var title: String?
    var activityLabelBackgroundColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureActivityLabel()
    }
    
    init(title: String, backgroundColor: UIColor, labelBackgroundColor: UIColor) {
        super.init(frame: .zero)
        self.title = title
        self.backgroundColor = backgroundColor
        self.activityLabelBackgroundColor = labelBackgroundColor
        configureView()
        configureActivityLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    private func configureActivityLabel() {
        self.addSubview(activityTypeLabel)
        
        activityTypeLabel.text = self.title
        activityTypeLabel.backgroundColor = self.activityLabelBackgroundColor
        activityTypeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            activityTypeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            activityTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityTypeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09),
            activityTypeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
}
