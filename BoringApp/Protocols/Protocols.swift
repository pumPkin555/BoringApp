//
//  Protocols.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import Foundation


@objc protocol UIViewProtocol {
    func configureView()
    @objc optional func setUpConstraints()
}

protocol UIViewControllerProtocol {
    func configureViewController()
    func setUpConstraints()
}

protocol BoringButtonDelegate {
    func set(link: String)
}

protocol SettingsDelegate {
    func set(model: HalfBoredActivity)
}

protocol BModel {
    var activity: String? { get }
    var accessibility: Double { get }
    var type: String? { get }
    var participants: Int64 { get }
    var price: Double { get }
    var link: String? { get }
    var key: String? { get }
}
