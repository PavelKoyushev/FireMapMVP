//
//  Network.swift
//  FireMap
//
//  Created by Pavel Koyushev on 21.10.2020.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFires(completion: @escaping(Result<[Fire]?,Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getFires(completion: @escaping (Result<[Fire]?, Error>) -> Void) {
        let urlString = "https://www.fire.ca.gov/umbraco/api/IncidentApi/List?inactive=1"
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
    
            do {
                let obj = try JSONDecoder().decode([Fire].self, from: data!)
                completion(.success(obj))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
