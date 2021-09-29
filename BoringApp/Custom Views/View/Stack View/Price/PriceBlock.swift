//
//  PriceBlock.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 24.09.2021.
//

import UIKit

class PriceBlock: UIView, UIViewProtocol {
    
    let array: [String] = ["free", "cheap", "avarage", "expensive"]
    let label: UILabel = UILabel()
    var segmentControl: UISegmentedControl!
    
    var selectedPrice: Price = .cheap(min: 0.0, max: 0.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLabel()
        configureSegmentControl()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure view
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
    }
    
    private func configureLabel() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PRICE"
        label.textAlignment = .left
        label.textColor = UIColor.secondaryLabel
    }
    
    private func configureSegmentControl() {
        segmentControl = UISegmentedControl(items: array)
        self.addSubview(segmentControl)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = UIColor.secondarySystemBackground
        segmentControl.tintColor = UIColor.systemGreen
        
        segmentControl.addTarget(self, action: #selector(choosePrice), for: .valueChanged)
    }
    
    //MARK: - Objective-C functions
    
    @objc private func choosePrice(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedPrice = .cheap(min: 0.0, max: 0.0)
        case 1:
            self.selectedPrice = .cheap(min: 0.1, max: 0.2)
        case 2:
            self.selectedPrice = .average(min: 0.2, max: 0.6)
        case 3:
            self.selectedPrice = .average(min: 0.6, max: 1.0)
        default:
            break
        }
        
//        NotificationCenter.default.post(name: .price, object: self.selectedPrice)
    }
    
    //MARK: - Constraints
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: label.bottomAnchor),
            segmentControl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            segmentControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            segmentControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
