//
//  Constants.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import UIKit

enum SFSymbols {
    static let some = UIImage(systemName: "xmark")
    static let human = UIImage(systemName: "person.circle")
    static let people = UIImage(systemName: "person.2.circle")
    static let question = UIImage(systemName: "questionmark.circle")
    static let bookmark = UIImage(systemName: "bookmark")
    static let bookmarkFill = UIImage(systemName: "bookmark.fill")
    static let arrowClockwiseCircle = UIImage(systemName: "arrow.clockwise.circle")
    static let filer = UIImage(systemName: "slider.horizontal.3")
    static let dollar = UIImage(systemName: "dollarsign.circle")
    static let link = UIImage(systemName: "link.circle.fill")
    static let error = UIImage(systemName: "xmark.circle")
    static let star = UIImage(systemName: "star")
}

enum Types: String {
    case education = "education"
    case recreational = "recreational"
    case social = "social"
    case diy = "diy"
    case charity = "charity"
    case cooking = "cooking"
    case relaxation = "relaxation"
    case music = "music"
    case busywork = "busywork"
}

enum Price {
    case cheap(min: Double, max: Double)
    case average(min: Double, max: Double)
}
