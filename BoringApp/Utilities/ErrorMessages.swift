//
//  Enums.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import Foundation


enum BAError: String, Error {
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorites  = "There was an error favoriting this user. Please try again."
}
