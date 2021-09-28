//
//  Protocols.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit


@objc protocol UIViewProtocol {
    func configureView()
    @objc optional func setUpConstraints()
}

protocol UIViewControllerProtocol {
    func configureViewController()
    func setUpConstraints()
}

protocol ActivityTypeProtocol {
    func set(type: Types)
}

protocol ParticipantsProtocol {
    func set(quantity: Int)
}
