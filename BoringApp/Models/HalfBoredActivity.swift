//
//  HalfBoredActivity.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 26.09.2021.
//

import Foundation

class HalfBoredActivity {
    let type: Types?
    let participants: Int?
    let price: (Double, Double)?
    
    init(type: Types?, participants: Int?, price: (Double, Double)?) {
        self.type = type
        self.participants = participants
        self.price = price
    }
}
