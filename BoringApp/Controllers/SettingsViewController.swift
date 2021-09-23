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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHand()
        configureSettingsBlock()
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
    }
}
