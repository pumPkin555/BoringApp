//
//  Constants.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 22.09.2021.
//

import Foundation

enum SFSymbols: String {
    case some = "xmark"
    case human = "person.circle"
    case people = "person.2.circle"
    case question = "questionmark.circle"
    case bookmark = "bookmark"
    case bookmarkFill = "bookmark.fill"
    case arrowClockwiseCircle = "arrow.clockwise.circle"
    case filer = "slider.horizontal.3"
    case dollar = "dollarsign.circle"
    case link = "link.circle.fill"
    case error = "xmark.circle"
    case star = "star"
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
