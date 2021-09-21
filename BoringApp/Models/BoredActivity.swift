//
//  File.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import Foundation

class BoredActivity: Decodable {
    var activity: String
    var accessibility: Double
    var type: String
    var participants: Int
    var price: Double
    var link: String
    var key: String
}
