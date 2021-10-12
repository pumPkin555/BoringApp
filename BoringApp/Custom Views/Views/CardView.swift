//
//  ActivityButton.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class CardView: UIView, UIViewProtocol {

    let activityLabel: ActivityLabel = ActivityLabel()
    let activityType: ActivityType = ActivityType()
    let participantView: BoringStackView = BoringStackView()
    let priceView: BoringStackView = BoringStackView()
    let linkButton: BoringButton = BoringButton()
    let linkImageView: MyImageView = MyImageView(image: SFSymbols.info!)
    
    var delegate: BoringButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureActivityTypeLabel()
        configureLinkImageView()
        configureActivityLabel()
        configureParticipantView()
        configurePriceView()
        configureLinkButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure view
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        self.backgroundColor = UIColor(named: "Card_Background")
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.secondaryLabel.cgColor
        
//        configureBlurEffect()
    }
    
    /* Unused
    private func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = self.bounds
        self.insertSubview(blurView, at: 0)
    }
    */
    
    private func configureActivityTypeLabel() {
        self.addSubview(activityType)
    }
    
    private func configureLinkImageView() {
        self.addSubview(linkImageView)
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
    
    private func configureLinkButton() {
        self.addSubview(linkButton)
        
        linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Configure card with model (API & CoreData)
    
    func set(with model: BModel) {
        
        self.activityLabel.set(text: model.activity ?? "")
        self.activityType.set(text: model.type ?? "")
        
        if (model.participants > 1) {
            self.participantView.set(image: SFSymbols.people!,
                                     text: "\(model.participants)")
        } else {
            self.participantView.set(image: SFSymbols.human!,
                                     text: "\(model.participants)")
        }
        
        self.priceView.set(image: SFSymbols.dollar!,
                           text: "\(model.price)")
        
        if (model.link != "") {
            if (model is BoredActivity) {
                self.linkButton.set(image: SFSymbols.link!,
                                    tintColor: UIColor.systemBlue,
                                    link: model.link)
                self.linkButton.hide(false)
                self.linkImageView.hide(true)
            } else {
                self.linkButton.hide(true)
                self.linkImageView.hide(false)
            }
        } else {
            self.linkButton.hide(true)
            self.linkImageView.hide(true)
        }
    }
    
    //MARK: - Objective-C functions
    
    @objc private func linkButtonTapped() {
        if let link = linkButton.getLink() {
            delegate?.set(link: link)
        }
    }
    
    //MARK: - Constraints
    
    func setUpConstraints() {
        
        let viewsArray: [UIView] = [participantView, priceView]
        
        NSLayoutConstraint.activate([
            activityType.topAnchor.constraint(equalTo: self.topAnchor),
            activityType.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityType.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.32),
            activityType.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
        
        NSLayoutConstraint.activate([
            linkImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            linkImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            linkImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            linkImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
        
        for view in viewsArray {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.29),
            ])
        }
        
        NSLayoutConstraint.activate([
            participantView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            priceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
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
            linkButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            linkButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            linkButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
