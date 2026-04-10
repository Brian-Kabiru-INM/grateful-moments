//
//  APIClient.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 30/03/2026.
//

import Foundation
import Combine

class APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint, body: Encodable? = nil) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
