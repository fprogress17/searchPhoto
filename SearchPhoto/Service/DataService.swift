//
//  DataService.swift
//  SearchPhoto
//
//  Created by Choonghun Lee on 9/23/24.
//

import Foundation
class DataService {
    func fetchPhotos<T: Codable>(url: URL, with completion: @escaping ((Result<T, NetworkError>) -> ())) {
        let sessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, requestError) in
            var error: NetworkError
            if let requestError = requestError {
                
                if let response = response as? HTTPURLResponse, (400..<600).contains(response.statusCode) {
                    error = .errorStatusCode(statusCode: response.statusCode)
                } else if requestError._code == NSURLErrorNotConnectedToInternet {
                    error = .notConnected
                } else if requestError._code == NSURLErrorCancelled {
                    error = .cancelled
                } else {
                    error = .requestError(requestError)
                }
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            else {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.noResponse))
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                   
                }
                catch {
                    DispatchQueue.main.async {
                        completion(.failure(.jsonError))
                    }
                }
            }
        }
        sessionDataTask.resume()
        }
}

public enum NetworkError: Error {
    case errorStatusCode(statusCode: Int)
    case noResponse
    case notConnected
    case cancelled
    case urlGeneration
    case jsonError
    case requestError(Error?)
}
