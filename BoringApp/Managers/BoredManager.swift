//
//  BoredManager.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import Foundation

class BoredManager {
    
    func fetchData(completion: @escaping (Result<BoredActivity, BAError>) -> Void) {
        let urlString: String = "https://www.boredapi.com/api/activity/"
        
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
                completion(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}
