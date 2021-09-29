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
    
    var delegate: SettingsDelegate?
    
    var type: Types? = nil
    var participants: Int? = nil
    var price: (Double, Double)? = nil

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
    
    //MARK: - Configure User Interface
    
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
        hand.layer.cornerRadius = 3
    }
    
    func configureDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = UIColor.systemBlue
        doneButton.setTitle("Done", for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.layer.masksToBounds = true

        doneButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    //MARK: - Support functions
    
    private func getPrice() {
        let type = self.settingsBlock.getParice()
        switch type {
        case .cheap(let min, let max):
            self.price = (min, max)
        case .average(let min, let max):
            self.price = (min, max)
        }
    }
    
    //MARK: - Objective-C functions
    
    @objc private func getType(notification: Notification) {
        type = notification.object as? Types
    }
    
    @objc private func getParticipants(notification: Notification) {
        participants = notification.object as? Int
    }
    
    @objc func dismissController() {
        self.getPrice()
        
        let model = HalfBoredActivity(type: self.type, participants: self.participants, price: self.price)
        delegate?.set(model: model)
        LonelyManager.shared.deleteAll()
        
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constraints

extension SettingsViewController {
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            hand.heightAnchor.constraint(equalToConstant: 6),
            hand.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            hand.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            hand.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            settingsBlock.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            settingsBlock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsBlock.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
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
