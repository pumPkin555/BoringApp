//
//  BoredManager.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import Foundation

class BoredManager {
    
    func fetchData(type: Types?, participants: Int?, price: Double?, completion: @escaping (Result<BoredActivity, BAError>) -> Void) {
        
        var participantsString = ""
        var priceStirng = ""
        var typeString = ""
        
        
        if (participants != nil) {
            participantsString = "participants=\(participants!)"
        }
        if (price != nil) {
            priceStirng = "&price=\(price!)"
        }
        if (type != nil) {
            typeString = "&type=\(type!.rawValue)"
        }
        
        let urlString: String = "https://www.boredapi.com/api/activity?\(participantsString)\(priceStirng)\(typeString)"
        
        guard let url = URL(string: urlString) else { return }
        
        let urlSession = URLSession.shared
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let activity = try decoder.decode(BoredActivity.self, from: data)
                completion(.success(activity))
            } catch {
                completion(.failure(error as! BAError))
            }
        }
        dataTask.resume()
    }
}
