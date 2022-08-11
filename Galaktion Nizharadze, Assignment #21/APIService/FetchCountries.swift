//
//  FetchCountries.swift
//  Galaktion Nizharadze, Assignment #21
//
//  Created by Gaga Nizharadze on 11.08.22.
//

import Foundation
import UIKit

protocol CountryService {
    func fetchCountry(completion: @escaping (Result<[Country],Error>) -> ())
}

class FetchCountries: CountryService {
    
    static let shared = FetchCountries()
    private init() {}
    
    private let baseAPIURL = "https://restcountries.com/v2/all"
    private let urlSession = URLSession.shared
    
    
    func fetchCountry(completion: @escaping (Result<[Country], Error>) -> ()) {
        guard let url = URL(string: baseAPIURL) else {
            print("url is not valid")
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { data, httpResponse, error in
            if let httpResponse = httpResponse {
                print("api http response -> ", httpResponse)
            }
            
            if let error = error {
                print("api error -> ", error)
            }
            
            guard let data = data else {
                print("api data is nil")
                return
            }
            
            do {
            let jsonData = try JSONDecoder().decode([Country].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}

extension UIImageView {

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
