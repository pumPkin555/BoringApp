//
//  LonelyManager.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 29.09.2021.
//

import Foundation


class LonelyManager {
    
    static let shared: LonelyManager = LonelyManager()
    
    private init() {}
    
    var currentArray: [String] {
        get {
            return array
        }
    }
    
    private var array: [String] = []
    
    func addType(with name: String) {
        array.append(name)
    }
    
    func delete(with name: String) {
        for i in 0..<array.count {
            if (array[i] == name) {
                array.remove(at: i)
            }
        }
    }
    
    func deleteAll() {
        array = []
    }
}
