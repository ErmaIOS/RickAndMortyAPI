//
//  NetworkLayer.swift
//  RickAndMortyAPI
//
//  Created by Erma on 8/7/24.
//

import Foundation

struct NetworkLayer {
    
    enum NetworkError: Error{
        case `default`(String),sessionEror(String)
    }
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func fetchCharacters(completion: @escaping (Result<[APIResponseResults],Error>) -> Void) {
        let url = Constants.baseURL!.appendingPathComponent("/character")
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response , error in
            if let error {
                completion(.failure(error))
            }
            if let data {
                do{
                    let model = try decoder.decode(APIResponse.self, from: data)
                    completion(.success(model.results))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
