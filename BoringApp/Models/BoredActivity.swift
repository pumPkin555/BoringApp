//
//  File.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import Foundation

struct BoredActivity: Decodable, BModel {
    var activity: String?
    var accessibility: Double
    var type: String?
    var participants: Int64
    var price: Double
    var link: String?
    var key: String?
}
