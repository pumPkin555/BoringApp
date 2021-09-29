//
//  BoringSegmentControl.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 29.09.2021.
//

import UIKit

class BoringSegmentControl: UISegmentedControl, UIViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
//    override init(items: [Any]?) {
//        <#code#>
//    }
    
    init(with array: [String]) {
        super.init(frame: .zero)
        self.accessibilityElements = array
        for i in 0..<array.count {
            self.setTitle(array[i], forSegmentAt: i)
        }
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.secondarySystemBackground
        self.tintColor = UIColor.systemGreen
    }
}
