//
//  Network.swift
//  SimpleWeatherApp
//
//  Created by Erkam Karaca on 26.05.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        
        let apiKeyQueryItem = URLQueryItem(name: "APPID", value: "63c3c40f26f37be4f78f26ec78566a19")
        let unitsQueryItem = URLQueryItem(name: "units", value: "metric")
        components.queryItems = [apiKeyQueryItem, unitsQueryItem]
        
        return components
    }
    
    func getWeatherURL(forID id: String) -> URL? {
        var updatedComponents = urlComponents
        let idQueryItem = URLQueryItem(name: "id", value: id)
        updatedComponents.queryItems?.append(idQueryItem)
        return updatedComponents.url
    }
}


func fetchData<T: Codable>(from url: URL, expecting: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
    let session = URLSession.shared
    
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            completionHandler(.failure(error))
            return
        }
        
        guard let data = data else {
            completionHandler(.failure(NSError(domain: "com.SimpleWeatherApp.api", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned from API"])))
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            completionHandler(.success(decodedData))
        } catch {
            completionHandler(.failure(error))
        }
    }
    task.resume()
}
