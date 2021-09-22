//
//  StackView.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

class StackView: UIView, UIViewProtocol {
    
    private var imageView: UIImageView = UIImageView()
    private var label: UILabel = UILabel()
    
    private let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    private var image: UIImage = UIImage()
    private var text: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.image = UIImage(systemName: SFSymbols.question.rawValue) ?? UIImage()
        configureView()
        configureParticipantImageView()
        configureParticipantLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, text: String) {
        self.image = image
        self.text = text
        
        configureView()
        configureParticipantImageView()
        configureParticipantLabel()
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
    }
    
    private func configureParticipantImageView() {
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imageView.tintColor = UIColor.white
    }
    
    private func configureParticipantLabel() {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
    }
    
    func setUpConstraints() {
        let viewArray: [UIView] = [imageView, label]
        
        for view in viewArray {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: self.heightAnchor),
                view.heightAnchor.constraint(equalTo: self.heightAnchor),
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
