//
//  JRKClient.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case put(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: String
    var method: HTTPMethod = .get([])
    var modelType: T.Type
}

// TODO - Make the errors more in line with the errorResponse from the api

actor JRKClient {
    static let shared = JRKClient()
    
    private let feedURL = URL(string: "https://webservices-jrk.onrender.com/api/")!
    private let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        let token: String? = try? Keychain.get("jwtToken")
        
        if let token {
            configuration.httpAdditionalHeaders?["Authorization"] = "Bearer \(token)"
        }
        
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async -> APIResult<T> {
        var request = URLRequest(url: feedURL.appendingPathComponent(resource.url))
        
        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: feedURL.appending(component: resource.url), resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                return APIResult(error: APIError.badRequest(message: "Er is een fout opgetreden tijdens het opvragen van de data."))
            }
            
            request = URLRequest(url: url)
        
        case .post(let data), .put(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
            
        case .delete:
            request.httpMethod = resource.method.name
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 400:
                    let errorResult = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print(errorResult.details.body)
                    return APIResult<T>(error: APIError.badRequest(message: errorResult.message))
                case 401:
                    let errorResult = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return APIResult<T>(error: APIError.unauthorized(message: errorResult.message))
                case 404:
                    let errorResult = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return APIResult<T>(error: APIError.notFound(message: errorResult.message))
                default: break
                }
            }
            
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return APIResult<T>(data: result)
        } catch {
            print(String(describing: error))
            return APIResult<T>(error: error as? APIError ?? APIError.unexpectedError(error: error))
        }
    }
}

