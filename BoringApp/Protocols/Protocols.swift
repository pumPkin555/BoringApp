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
