//
//  SettingsViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class SettingsViewController: UIViewController, UIViewControllerProtocol {
    
    let hand: UIView = UIView()
    let settingsBlock: SettingsViewBlock = SettingsViewBlock()
    let doneButton: UIButton = UIButton()
    
    var type: Types?
    var participants: Int?
    var price: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHand()
        configureSettingsBlock()
        configureDoneButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getType(notification:)), name: .typeName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getParticipants(notification:)), name: .participants, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    func configureViewController() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    func configureSettingsBlock() {
        view.addSubview(settingsBlock)
    }
    
    func configureHand() {
        view.addSubview(hand)
        hand.translatesAutoresizingMaskIntoConstraints = false
        hand.backgroundColor = UIColor.systemGray3
        hand.layer.cornerRadius = 5
    }
    
    func configureDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = UIColor.systemBlue
        doneButton.setTitle("Done", for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.layer.masksToBounds = true

        doneButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.colors = [UIColor.systemOrange.cgColor, UIColor.systemRed.cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        gradient.locations = [0.0, 0.7]
//        gradient.frame = doneButton.bounds
//        doneButton.layer.insertSublayer(gradient, at: 0)
    }
    
    @objc private func getType(notification: Notification) {
        type = notification.object as? Types
    }
    
    @objc private func getParticipants(notification: Notification) {
        participants = notification.object as? Int
    }
    
    @objc func dismissController() {
        let halfBoredActivity = HalfBoredActivity(type: self.type ?? Types.charity, participants: self.participants ?? 1, price: 0)
        NotificationCenter.default.post(name: .halfBoredParticipants, object: halfBoredActivity)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            hand.heightAnchor.constraint(equalToConstant: 7),
            hand.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            hand.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            hand.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingsBlock.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            settingsBlock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsBlock.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            settingsBlock.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
        ])
        
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
