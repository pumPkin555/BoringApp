//
//  ActivityButton.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class CardView: UIView {

    let activityLabel: ActivityLabel = ActivityLabel()
    let activityType: ActivityType = ActivityType()
    let participantView: BoringStackView = BoringStackView()
    let priceView: BoringStackView = BoringStackView()
    let bookMark: BoringButton = BoringButton()
    let linkButton: BoringButton = BoringButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureActivityTypeLabel()
        configureActivityLabel()
        configureParticipantView()
        configurePriceView()
        configureBookMark()
    }
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        configureView()
        configureActivityTypeLabel()
        configureActivityLabel()
        configureParticipantView()
        configurePriceView()
        configureBookMark()
        configureLinkButton()
    }
    
    func set(with model: BoredActivity) {
        
        self.activityLabel.set(text: model.activity)
        self.activityType.set(text: model.type)
        
        if (model.participants > 1) {
            self.participantView.set(image: UIImage(systemName: SFSymbols.people.rawValue) ?? UIImage(), text: "\(model.participants)")
        } else {
            self.participantView.set(image: UIImage(systemName: SFSymbols.human.rawValue) ?? UIImage(), text: "\(model.participants)")
        }
        
        self.priceView.set(image: UIImage(systemName: SFSymbols.dollar.rawValue) ?? UIImage(), text: "\(model.price)")
        self.bookMark.set(image: UIImage(systemName: SFSymbols.bookmark.rawValue) ?? UIImage(), tintColor: UIColor.white, link: nil)
        
        configureView()
        configureActivityTypeLabel()
        configureActivityLabel()
        configureParticipantView()
        configurePriceView()
        configureBookMark()
        
        if (model.link != "") {
            self.linkButton.set(image: UIImage(systemName: SFSymbols.link.rawValue) ?? UIImage(), tintColor: UIColor.systemBlue, link: model.link)
            
            configureLinkButton()
        }
    }
    
    func set2(with model: SavedBoredActivity) {
        
        self.activityLabel.set(text: model.activity ?? "None")
        self.activityType.set(text: model.type ?? "None")
        
        if (model.participants > 1) {
            self.participantView.set(image: UIImage(systemName: SFSymbols.people.rawValue) ?? UIImage(), text: "\(model.participants)")
        } else {
            self.participantView.set(image: UIImage(systemName: SFSymbols.human.rawValue) ?? UIImage(), text: "\(model.participants)")
        }
        
        self.priceView.set(image: UIImage(systemName: SFSymbols.dollar.rawValue) ?? UIImage(), text: "\(model.price)")
        self.bookMark.set(image: UIImage(systemName: SFSymbols.bookmark.rawValue) ?? UIImage(), tintColor: UIColor.white, link: nil)
        
        configureView()
        configureActivityTypeLabel()
        configureActivityLabel()
        configureParticipantView()
        configurePriceView()
        configureBookMark()
        
        if (model.link != "") {
            self.linkButton.set(image: UIImage(systemName: SFSymbols.link.rawValue) ?? UIImage(), tintColor: UIColor.systemBlue, link: model.link)
            
            configureLinkButton()
        }
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
    
    private func configureActivityTypeLabel() {
        self.addSubview(activityType)
    }
    
    private func configureActivityLabel() {
        self.addSubview(activityLabel)
    }
    
    private func configureParticipantView() {
        self.addSubview(participantView)
    }
    
    private func configurePriceView() {
        self.addSubview(priceView)
    }
    
    private func configureBookMark() {
        self.addSubview(bookMark)
        
        bookMark.addTarget(self, action: #selector(bookMarkTapped), for: .touchUpInside)
    }
    
    private func configureLinkButton() {
        self.addSubview(linkButton)
    }
    
    private func setUpConstraints() {
        let viewsArray: [UIView] = [participantView, priceView]
        
        NSLayoutConstraint.activate([
            activityType.topAnchor.constraint(equalTo: self.topAnchor),
            activityType.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityType.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.32),
            activityType.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
        
        for view in viewsArray {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            ])
        }
        
        NSLayoutConstraint.activate([
            bookMark.topAnchor.constraint(equalTo: self.topAnchor),
            bookMark.widthAnchor.constraint(equalTo: activityType.heightAnchor),
            bookMark.heightAnchor.constraint(equalTo: activityType.heightAnchor),
            bookMark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            participantView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            priceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            participantView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            priceView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            activityLabel.topAnchor.constraint(equalTo: activityType.bottomAnchor),
            activityLabel.bottomAnchor.constraint(equalTo: participantView.topAnchor),
            activityLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            activityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            linkButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            linkButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.07),
            linkButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            linkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func bookMarkTapped() {
        if (bookMark.imageView?.image == UIImage(systemName: SFSymbols.bookmark.rawValue)) {
            bookMark.set(image: UIImage(systemName: SFSymbols.bookmarkFill.rawValue) ?? UIImage(), tintColor: UIColor.white, link: nil)
        } else {
            bookMark.set(image: UIImage(systemName: SFSymbols.bookmark.rawValue) ?? UIImage(), tintColor: UIColor.white, link: nil)
        }
    }
}
