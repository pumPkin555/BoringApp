//
//  ActivityButton.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class ActivityButton: UIButton, UIViewProtocol {
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private var animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
    
    var delegate: ActivityTypeProtocol?
    
//    var gradientLayer: CAGradientLayer! {
//        didSet {
//            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//            gradientLayer.locations = [0.0, 0.4]
//            gradientLayer.colors = [UIColor.systemRed.cgColor, UIColor.systemBlue.cgColor]
//        }
//    }
//    var animation: CABasicAnimation! {
//        didSet {
//            animation.fromValue = [0.0, 0.4]
//            animation.toValue = [0.7, 1.5]
//            animation.autoreverses = true
//            animation.duration = 4
//            animation.repeatCount = .infinity
//        }
//    }
    
    var highlight: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    init(title: String, color1: CGColor, color2: CGColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        
        print("Created \(title)")

        configureGradient(colors: [color1, color2])
        configureAnimations()
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        round(corners: [.topLeft, .bottomRight], radius: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
//        gradientLayer = CAGradientLayer()
        self.layer.insertSublayer(gradientLayer, at: 0)

        animation = CABasicAnimation(keyPath: "locations")
        gradientLayer.add(animation, forKey: nil)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.systemBackground, for: .highlighted)
        self.alpha = 0.4
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func configureGradient(colors: [CGColor]) {
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.0, 0.4]
    }

    private func configureAnimations() {
        animation.fromValue = [0.0, 0.4]
        animation.toValue = [0.7, 1.5]
        animation.autoreverses = true
        animation.duration = 2
        animation.repeatCount = .infinity

        gradientLayer.add(animation, forKey: nil)
    }
    
    @objc private func buttonTapped() {
        
        if (highlight) {
            self.alpha = 0.4
            self.highlight = false
        } else {
            self.alpha = 1.0
            self.highlight = true
            NotificationCenter.default.post(name: .typeName, object: Types(rawValue: self.titleLabel?.text ?? "Jopa")) // self.titleLabel?.text ?? "Jopa"
        }
    }
}
