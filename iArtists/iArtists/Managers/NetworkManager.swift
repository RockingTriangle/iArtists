//
//  NetworkManager.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import UIKit

final class NetworkManager {
    
    // Shared instance of NetworkManager class
    static let shared = NetworkManager()
    
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Properties
    var searchParameter: String?
    var url: URL? {
        let baseURL = "https://itunes.apple.com/search"
        
        guard let url = URL(string: baseURL),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        let artistName = URLQueryItem(name: "term", value: searchParameter)
        let resultLimit = URLQueryItem(name: "limit", value: "200")
        components.queryItems = [artistName, /*resultType,*/ resultLimit]
        
        return components.url
    }
    
    // MARK: - Functions
    func searchArtistTracks(completion: @escaping (Result<[Track], NetworkError>) -> ()) {
        
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200  {
                completion(.failure(.non200Response(response)))
                print("Invalid response from server: \(response.description)")
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Tracks.self, from: data)
                decodedResponse.results.isEmpty ? completion(.failure(.noData)) : completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    } // End of searchArtistTracks function
    
    func downloadTrackCover(fromURLString urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200  {
                completion(nil)
                print("Invalid response from server: \(response.description)")
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    } // End of downloadTrackCover function
    
} // End of class
