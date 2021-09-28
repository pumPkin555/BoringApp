//
//  BoringStackView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 26.09.2021.
//

import UIKit

class BoringStackView: UIStackView, UIViewProtocol {

    private var imageView: UIImageView = UIImageView()
    private var label: UILabel = UILabel()
    
    private let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    private var image: UIImage = UIImage()
    private var text: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, text: String) {
        self.image = image
        self.text = text
        
        configureView()
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.axis = .horizontal
        self.spacing = 4
        self.distribution = .fillEqually
        
        configureParticipantImageView()
        configureParticipantLabel()
        
        let views: [UIView] = [imageView, label]
        
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    private func configureParticipantImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imageView.tintColor = UIColor.white
    }
    
    private func configureParticipantLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
    }
}
